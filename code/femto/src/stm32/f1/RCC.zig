const std = @import("std");
const mem_map = @import("memmap.zig");
const rcc_reg = packed struct {
    cr: u32,
    cfgr: u32,
    cir: u32,
    apb2rstr: u32,
    apb1rstr: u32,
    ahbenr: u32,
    apb2enr: u32,
    apb1enr: u32,
    bdcr: u32,
    csr: u32,
};

pub const GPIO_ids = [_]u6{ 2, 3, 4, 5, 6, 7, 8 };
pub const ADC_ids = [_]u6{ 9, 10 };
pub const SPI_ids = [_]u6{ 12, 32 + 14, 32 + 15 };

const reg = @intToPtr(*rcc_reg, mem_map.rcc);

pub fn init_periph(id: u6) void {
    if (id > 32) {
        reg.apb1enr |= @as(u32, 1) << @truncate(u5, id - 32);
    } else {
        reg.apb2enr |= @as(u32, 1) << @truncate(u5, id);
    }
}

pub const clock_config = struct {
    ext_osc: u32,
    sysclock: u32,
    ahbclock: u32,
    apb1clock: u32,
    apb2clock: u32,
};
pub const clock_vals = packed struct {
    sw: u2,
    sws: u2,
    hpre: u4,
    ppre1: u3,
    ppre2: u3,
    adcpre: u2,
    pllsrc: u1,
    pllxtpre: u1,
    pllmul: u4,
    usbpre: u1,
    res: u1 = 0,
    mco: u3,
    res_2: u5 = 0,
};

comptime {
    std.debug.assert(@sizeOf(clock_vals) == 4);
}

pub fn clocks_gen(config: clock_config) clock_vals {
    const pll_options = [_]usize{ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 16 };
    const pll_vals = [_]u4{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const pre_options = [_]usize{ 1, 2 };
    const pre_vals = [_]u1{ 0, 1 };

    var pll_set: ?usize = null;
    var pre_set: ?usize = null;
    outer: for (pll_options) |pll, pll_idx| {
        for (pre_options) |pre, pre_idx| {
            if (((config.ext_osc / pre) * pll) == config.sysclock) {
                pll_set = pll_idx;
                pre_set = pre_idx;
                break :outer;
            }
        }
    }
    if (pll_set == null) {
        unreachable;
    }

    const ahb_pre_options = [_]usize{ 1, 2, 4, 8, 16, 64, 128, 256, 512 };
    const ahb_pre_vals = [_]u4{ 0, 8, 9, 10, 11, 12, 13, 14, 15 };
    var ahb_set: ?usize = null;

    for (ahb_pre_options) |ahb, idx| {
        if (config.sysclock / ahb == config.ahbclock) {
            ahb_set = idx;
        }
    }
    if (ahb_set == null) {
        unreachable;
    }

    const ap_pre_options = [_]usize{ 1, 2, 4, 8, 16 };
    const ap_pre_vals = [_]u3{ 0, 4, 5, 6, 7 };
    var apb2_set: ?usize = null;
    var apb1_set: ?usize = null;
    for (ap_pre_options) |ap, idx| {
        if (config.ahbclock / ap == config.apb1clock) apb1_set = idx;
        if (config.ahbclock / ap == config.apb2clock) apb2_set = idx;
    }
    if (apb2_set == null) unreachable;
    if (apb1_set == null) unreachable;

    const vals = clock_vals{
        .sw = 0b10,
        .sws = 0b01,
        .hpre = ahb_pre_vals[ahb_set.?],
        .ppre1 = ap_pre_vals[apb1_set.?],
        .ppre2 = ap_pre_vals[apb2_set.?],
        .adcpre = 2, //TODO:workout adc,
        .pllsrc = 1,
        .pllxtpre = pre_vals[pre_set.?],
        .pllmul = pll_vals[pll_set.?],
        .usbpre = 1, //TODO
        .mco = 0,
    };
    return vals;
}

pub fn init_clocks(config: clock_vals) void {
    reg.cr |= 1 << 16;
    while ((reg.cr & 1 << 17) == 0) {}

    reg.cfgr = @bitCast(u32, config);
}
