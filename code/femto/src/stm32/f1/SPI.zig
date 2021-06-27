const mem_map = @import("memmap.zig");
const gpio = @import("GPIO.zig");
const rcc = @import("RCC.zig");
const spi_reg = struct {
    cr1: u32,
    cr2: u32,
    sr: u32,
    dr: u32,
    crcp: u32,
    rxcrc: u32,
    txcrc: u32,
    i2scfgr: u32,
    i2sp: u32,
};

const regs = [_]*spi_reg{
    @intToPtr(*spi_reg, mem_map.spi[0]),
    @intToPtr(*spi_reg, mem_map.spi[1]),
};

const spi_pins = struct {
    mosi: gpio.pin_config,
    miso: gpio.pin_config,
    sclk: gpio.pin_config,
    spi_port: u8,
};

pub fn spi1_pins(version: u32) spi_pins {
    switch (version) {
        0 => {
            return spi_pins{
                .mosi = .{
                    .port = 0,
                    .pin = 7,
                    .mode = .{ .output = .AF_PUSHPULL },
                },
                .miso = .{
                    .port = 0,
                    .pin = 6,
                    .mode = .{ .input = .Floating },
                },
                .sclk = .{
                    .port = 0,
                    .pin = 5,
                    .mode = .{ .output = .AF_PUSHPULL },
                },
                .spi_port = 0,
            };
        },
        1 => {
            return spi_pins{
                .mosi = .{
                    .port = 0,
                    .pin = 7,
                    .mode = .{ .output = .AF_PUSHPULL },
                },
                .miso = .{
                    .port = 0,
                    .pin = 6,
                    .mode = .{ .input = .Floating },
                },
                .sclk = .{
                    .port = 0,
                    .pin = 5,
                    .mode = .{ .output = .AF_PUSHPULL },
                },
                .spi_port = 0,
            };
        },
        else => unreachable,
    }
}

pub const Mode = enum(u1) {
    Slave = 0,
    Master = 1,
};

pub const ClockPol = enum(u1) {
    IDLE_0 = 0,
    IDLE_1 = 1,
};

pub const ClockPhase = enum(u1) {
    first_clock = 0,
    second_clock = 1,
};

pub const Endian = enum(u1) {
    Big = 0,
    Little = 1,
};

pub const FrameFormat = enum(u1) {
    Bit8 = 0,
    Bit16 = 1,
};

pub const spi_config = struct {
    pins: spi_pins,
    ss: gpio.pin_config,
    phase: ClockPhase,
    clock_pol: ClockPol,
    master: Mode,
    baud: u3,
    endian: Endian,
    data_size: FrameFormat,
};

pub fn init_spi(config: spi_config) void {
    rcc.init_periph(rcc.SPI_ids[config.pins.spi_port]);
    rcc.init_periph(0);

    gpio.init_pin(config.pins.mosi);
    gpio.init_pin(config.pins.miso);
    gpio.init_pin(config.pins.sclk);
    gpio.init_pin(config.ss);

    var reg: *u32 = @intToPtr(*u32, 0x40013000);
    reg.* &= (1 << 6) | (1 << 13) | (1 << 12);

    reg.* |= (1 << 2);
    reg.* |= (0b100 << 3);
    reg.* |= (1 << 11);
    reg.* |= (1 << 6);
}

pub fn transfer_spi(config: spi_config, data: u16) u16 {
    gpio.write_pin(config.ss, .High);
    while ((regs[config.pins.spi_port].sr & 0b10) == 0) {}
    regs[config.pins.spi_port].dr = data;
    while ((regs[config.pins.spi_port].sr & 0b10) == 0) {}
    //const val = @truncate(u16, regs[config.pins.spi_port].dr);
    gpio.write_pin(config.ss, .Low);
    return 0; //val;
}
