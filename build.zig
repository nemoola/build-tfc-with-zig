const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    exe.addCSourceFile(.{
        .file = b.path("src/main.c"),
    });
    exe.addLibraryPath(b.path("lib"));
    exe.linkSystemLibrary("tensorflow");
    exe.addIncludePath(b.path("include"));

    exe.use_lld = false;

    exe.linkLibC();
    b.installArtifact(exe);
}
