const mem_map = @import("memmap.zig");
const rcc = @import("RCC.zig");
pub const outputMode = enum(u4) {
    GP_PUSHPULL = 0b0011,
    GP_OPENDRAIN = 0b0111,
    AF_PUSHPULL = 0b1011,
    AF_OPENDRAIN = 0b1111,
};

pub const inputMode = enum {
    Analog,
    Floating,
    PullUp,
    PullDown,
};

pub const pin_mode = union(enum) {
    output: outputMode,
    input: inputMode,
};

pub const pin_value = enum {
    High,
    Low,
};

pub const pin_output = struct {
    port: u8,
    pin: u8,
    value: pin_value,
};

pub const pin_config = struct {
    port: u8,
    pin: u8,
    mode: pin_mode,
};

const gpio_reg = packed struct {
    cr: [2]u32,
    idr: u32,
    odr: u32,
    bsrr: u32,
    brr: u32,
    lckr: u32,
};

const regs = [_]*gpio_reg{
    @intToPtr(*gpio_reg, mem_map.gpio[0]),
    @intToPtr(*gpio_reg, mem_map.gpio[1]),
    @intToPtr(*gpio_reg, mem_map.gpio[2]),
    @intToPtr(*gpio_reg, mem_map.gpio[3]),
    @intToPtr(*gpio_reg, mem_map.gpio[4]),
    @intToPtr(*gpio_reg, mem_map.gpio[5]),
    @intToPtr(*gpio_reg, mem_map.gpio[6]),
};

pub fn init_pin(p: pin_config) void {
    const pos = @truncate(u5, (p.pin % 8) * 4);
    regs[p.port].cr[p.pin / 8] &= ~(@as(u32, 0xF) << pos);
    switch (p.mode) {
        .output => |o| {
            regs[p.port].cr[p.pin / 8] |= @intCast(u32, @enumToInt(o)) << pos;
        },
        .input => |i| {
            switch (i) {
                .PullUp => {
                    regs[p.port].cr[p.pin / 8] |= @as(u32, 0b1000) << pos;
                    regs[p.port].odr |= @as(u32, 1) << @truncate(u5, p.pin);
                },
                .PullDown => {
                    regs[p.port].cr[p.pin / 8] |= @as(u32, 0b1000) << pos;
                    regs[p.port].odr &= ~(@as(u32, 1) << @truncate(u5, p.pin));
                },
                .Floating => {
                    regs[p.port].cr[p.pin / 8] |= @as(u32, 0b0100) << pos;
                },
                .Analog => {
                    regs[p.port].cr[p.pin / 8] |= @as(u32, 0b0000) << pos;
                },
            }
        },
    }
}

pub fn init_pins(pins: []const pin_config) void {
    for (pins) |p| {
        init_pin(p);
    }
}

pub fn write_pin(p: pin_config, value: pin_value) void {
    switch (value) {
        .High => regs[p.port].bsrr |= @as(u32, 1) << @truncate(u5, p.pin),
        .Low => regs[p.port].bsrr |= @as(u32, 1) << 16 + @truncate(u5, p.pin),
    }
}

pub fn write_pins(pins: []const pin_config, values: []const pin_value) void {
    for (pins) |p, idx| {
        write_pin(p, values[idx]);
    }
}

pub fn read_pins(pins: []const pin_config, values: []pin_value) void {
    for (pins) |p, idx| {
        values[idx] = if (regs[p.port].idr & (1 << p.pin) == 0) .Low else .High;
    }
}
