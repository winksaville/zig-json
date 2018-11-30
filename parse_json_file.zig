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

fn readFile(pAllocator: *Allocator, file_name: []const u8) ![]const u8 {
    if (DBG) warn("parse_json_file: readFile file_name={}\n", file_name);
    var file = try os.File.openRead(file_name);
    defer file.close();

    const file_size = try file.getEndPos();
    var buff = try pAllocator.alloc(u8, file_size);
    _ = try file.read(buff);
    return buff;
}

fn getFileSize(file_name: []const u8) !usize {
    var file = try os.File.openRead(file_name);
    defer file.close();

    return try file.getEndPos();
}

const geo = @import("modules/zig-geometry/index.zig");
const Mesh = geo.Mesh;
const Vertex = geo.Vertex;
const Face = geo.Face;

test "parse_json_file.readFile" {
    var file_name = "modules/3d-test-resources/suzanne.babylon";
    var pAllocator = std.heap.c_allocator;
    var contents = try readFile(pAllocator, file_name);
    //warn("suzanne contents:\n{}\n", contents);
    var file_size = try getFileSize(file_name);
    assert(contents[0] == '{');
    assert(contents[file_size-1] == '}');
}

test "parse_json_file.dump.suzanne" {
    var file_name = "modules/3d-test-resources/suzanne.babylon";
    var pAllocator = std.heap.c_allocator;
    var tree = try parseJsonFile(pAllocator, file_name);
    defer tree.deinit();

    var root = tree.root;
    if (DBG) {
        warn("\n");
        root.dumpIndent(2);
        warn("\n");
    }

    var meshes = root.Object.get("meshes");
    assert(meshes != null);
}
