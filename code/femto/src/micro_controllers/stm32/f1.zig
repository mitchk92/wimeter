const pin = @import("pin.zig");

pub fn stm32f103(comptime model: []const u8) micro_controller_info {
    const pincount = switch (model[9]) { //package
        'T' => 36,
        'C' => 48,
        'R' => 64,
        'V' => 100,
        'Z' => 144,
    };
    const memory = switch (model[10]) { //memory
        '4' => .{ .rom = 20, .ram = 6 },
        '6' => .{ .rom = 32, .ram = 10 },
        '8' => .{ .rom = 64, .ram = 20 },
        'B' => .{ .rom = 128, .ram = 20 },
        'C' => .{ .rom = 256, .ram = 48 },
        'D' => .{ .rom = 384, .ram = 64 },
        'E' => .{ .rom = 512, .ram = 64 },
        'F' => .{ .rom = 768, .ram = 96 },
        'G' => .{ .rom = 1000, .ram = 96 },
    };
}

const pin_variants = [_][]const u8{ "LFBGA100", "UFBG100", "LQFP48", "TFBGA64", "LQFP100", "VFQFPN36" };

const pin_desc = struct {
    id: usize,
    variant: [pin_variants.len]bool,
    name: []const u8,
    AF: []const u8, // TODO: make this a useful struct
};

const f103_pins = [_]pin_desc{
    .{ .id = 0, .variant = [_]bool{ true, true, false, false, false, true, false }, .AF = "TRACECK" },
    .{ .id = 0, .variant = [_]bool{ true, true, false, false, false, true, false }, .AF = "TRACED0" },
};
