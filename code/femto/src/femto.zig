const stm32 = @import("stm32f103.zig");

fn bad_delay(count: usize) void {
    var out_count: usize = 0;
    while (out_count < count) : (out_count += 1) {
        var in_count: usize = 0;
        while (in_count < 1000) : (in_count += 1) {}
    }
}

const comm_endp = usb.endpoint_description.init(
    .endpoint,
    0x83,
    usb.attribute.Interrupt,
    16,
    256,
);

const data_endp = [_]usb.endpoint_desciptor{
    usb.endpoint_desciptor.init(
        .endpoint,
        0x01,
        usb.attribute.Bulk,
        64,
        1,
    ),
    usb.endpoint_desciptor.init(
        .endpoint,
        0x82,
        usb.attribute.Bulk,
        64,
        1,
    ),
};

pub fn begin() void {
    const clock_config = comptime stm32.RCC.clocks_gen(.{
        .ext_osc = 08000000,
        .sysclock = 72000000,
        .ahbclock = 72000000,
        .apb1clock = 36000000,
        .apb2clock = 36000000,
    });
    stm32.RCC.init_clocks(clock_config);
    stm32.RCC.init_periph(3);
    stm32.RCC.init_periph(2);
    const spi_config = stm32.SPI.spi_config{
        .pins = stm32.SPI.spi1_pins(0),
        .ss = .{
            .port = 1,
            .pin = 1,
            .mode = .{ .output = .GP_PUSHPULL },
        },
        .phase = .first_clock,
        .clock_pol = .IDLE_0,
        .master = .Master,
        .baud = 0b100,
        .endian = .Big,
        .data_size = .Bit8,
    };
    _ = stm32.USB.do_thing();
    stm32.SPI.init_spi(spi_config);

    const gpio_val = [_]stm32.GPIO.pin_config{
        .{
            .port = 1,
            .pin = 14,
            .mode = .{
                .output = .GP_PUSHPULL,
            },
        },
        .{
            .port = 1,
            .pin = 15,
            .mode = .{
                .output = .GP_PUSHPULL,
            },
        },
        .{
            .port = 0,
            .pin = 8,
            .mode = .{
                .output = .GP_PUSHPULL,
            },
        },
        .{
            .port = 0,
            .pin = 9,
            .mode = .{
                .output = .GP_PUSHPULL,
            },
        },
    };

    stm32.GPIO.init_pins(gpio_val[0..]);
    var values_on = [_]stm32.GPIO.pin_value{
        .High,
        .Low,
        .High,
        .Low,
    };
    var values_off = [_]stm32.GPIO.pin_value{
        .Low,
        .High,
        .Low,
        .High,
    };
    while (true) {
        stm32.GPIO.write_pins(gpio_val[0..], values_on[0..]);
        _ = stm32.SPI.transfer_spi(spi_config, 0xDEAD);
        bad_delay(1);
        stm32.GPIO.write_pins(gpio_val[0..], values_off[0..]);
        _ = stm32.SPI.transfer_spi(spi_config, 0xBEEF);
        bad_delay(1);
    }
}
