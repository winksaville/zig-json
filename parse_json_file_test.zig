const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;
const Allocator = std.mem.Allocator;

const os = std.os;
const File = os.File;

const PJF = @import("parse_json_file.zig");

const DBG = false;

const geo = @import("modules/zig-geometry/index.zig");
const Mesh = geo.Mesh;
const Vertex = geo.Vertex;
const Face = geo.Face;

test "parse_json_file.readFile" {
    var file_name = "modules/3d-test-resources/suzanne.babylon";
    var pAllocator = std.heap.c_allocator;
    var contents = try PJF.readFile(pAllocator, file_name);
    //warn("suzanne contents:\n{}\n", contents);
    var file_size = try PJF.getFileSize(file_name);
    assert(contents[0] == '{');
    assert(contents[file_size - 1] == '}');
}

test "parse_json_file.dump.suzanne" {
    var file_name = "modules/3d-test-resources/suzanne.babylon";
    var pAllocator = std.heap.c_allocator;
    var tree = try PJF.parseJsonFile(pAllocator, file_name);
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
