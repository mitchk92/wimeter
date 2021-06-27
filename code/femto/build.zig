const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = .{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
        .os_tag = .freestanding,
        .abi = .eabihf,
    };
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const elf = b.addExecutable("femto", "src/vector.zig");
    elf.setTarget(target);
    elf.setBuildMode(mode);

    elf.setLinkerScriptPath(std.build.FileSource.relative("src/linker.ld"));

    elf.install();

    const flash_cmd = b.addSystemCommand(&[_][]const u8{
        "openocd",
        "-f",
        "interface/stlink-v2.cfg",
        "-f",
        "target/stm32f1x.cfg",
        "-c",
        "init",
        "-c",
        "targets",
        "-c",
        "halt",
        "-c",
        "flash write_image erase ./zig-out/bin/femto",
        "-c",
        "flash verify_image ./zig-out/bin/femto",
        "-c",
        "reset run",
        "-c",
        "shutdown",
    });
    flash_cmd.step.dependOn(b.getInstallStep());

    const flash_step = b.step("flash", "Flash and run");
    flash_step.dependOn(&flash_cmd.step);

    b.default_step.dependOn(&elf.step);
}
