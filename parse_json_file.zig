const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;
const Allocator = std.mem.Allocator;

const os = std.os;
const File = os.File;

const json = @import("json.zig");

const DBG = false;

pub fn parseJsonFile(pAllocator: *Allocator, file_name: []const u8) !json.ValueTree {
    var contents = try readFile(pAllocator, file_name);
    if (!json.validate(contents)) return error.InvalidJsonFile;
    var parser = json.Parser.init(pAllocator, false);
    return try parser.parse(contents);
}

pub fn readFile(pAllocator: *Allocator, file_name: []const u8) ![]const u8 {
    if (DBG) warn("parse_json_file: readFile file_name={}\n", file_name);
    var file = try os.File.openRead(file_name);
    defer file.close();

    const file_size = try file.getEndPos();
    var buff = try pAllocator.alloc(u8, file_size);
    _ = try file.read(buff);
    return buff;
}

pub fn getFileSize(file_name: []const u8) !usize {
    var file = try os.File.openRead(file_name);
    defer file.close();

    return try file.getEndPos();
}
