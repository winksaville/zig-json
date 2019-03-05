# Zig json parsing

Add support for Floats to zig/std/json\*. Since zig cannot
yet parse Floats I've created this standalone module and
using the ParseNumber module.

## Dependencies

* [zig](https://ziglang.org)
* [zig-parse-number](https://github.com/winksaville/zig-parse-number)

## Use

See the source files and tests for examples, I'm not aware of any other
documentation.

To clone this repo use `git clone --recursive` as zig-parse-number
is a git submodule.

```bash
git clone --recursive https://github.com/winksaville/zig-json path.to.zig-json
```

## Test
```bash
wink@wink-desktop:~/prgs/ziglang/zig-json (master)
$ zig test json.zig
Test 1/9 token...OK
Test 2/9 json validate...OK
Test 3/9 json parser dynamic...OK
Test 4/9 ParseNumber.parseIntegerNumber...OK
Test 5/9 ParseNumber.parseFloatNumber...OK
Test 6/9 ParseNumber...OK
Test 7/9 ParseNumber.errors...OK
Test 8/9 ParseNumber.non-u8-sizes...OK
Test 9/9 ParseNumber.parseF32...OK
All tests passed.
wink@wink-desktop:~/prgs/ziglang/zig-json (master)
$ zig test json_test.zig
Test 1/319 y_trailing_comma_after_empty...OK
Test 2/319 y_array_arraysWithSpaces...OK
Test 3/319 y_array_empty...OK
Test 4/319 y_array_empty-string...OK
Test 5/319 y_array_ending_with_newline...OK
Test 6/319 y_array_false...OK
Test 7/319 y_array_heterogeneous...OK
Test 8/319 y_array_null...OK
Test 9/319 y_array_with_1_and_newline...OK
Test 10/319 y_array_with_leading_space...OK
Test 11/319 y_array_with_several_null...OK
Test 12/319 y_array_with_trailing_space...OK
Test 13/319 y_number_0e+1...OK
Test 14/319 y_number_0e1...OK
Test 15/319 y_number_after_space...OK
Test 16/319 y_number_double_close_to_zero...OK
Test 17/319 y_number_int_with_exp...OK
...
Test 315/319 i_string_UTF-16LE_with_BOM...OK
Test 316/319 i_string_UTF-8_invalid_sequence...OK
Test 317/319 i_string_UTF8_surrogate_U+D800...OK
Test 318/319 i_structure_500_nested_arrays...OK
Test 319/319 i_structure_UTF-8_BOM_empty_object...OK
All tests passed.
$ zig test parse_json_file_test.zig --library c
Test 1/22 parse_json_file.readFile...OK
Test 2/22 parse_json_file.dump.suzanne...OK
Test 3/22 json.json.token...OK
Test 4/22 json.json.validate...OK
Test 5/22 json.json.Value.asFloat...OK
Test 6/22 json.json.parser.dynamic...OK
Test 7/22 json.json.array.mixed...OK
Test 8/22 json.json.array.of.numbers...OK
Test 9/22 json.json.simple.numbers...OK
Test 10/22 json.json.single.leading.zero.before.decimal...OK
Test 11/22 json.json.leading.zero.integer...OK
Test 12/22 json.json.leading.zero.float.before.ones.digit...OK
Test 13/22 modules.zig-parse-number.parse_number.ParseNumber.parseFloat...OK
Test 14/22 modules.zig-parse-number.parse_number.ParseNumber.parseIntegerNumber...OK
Test 15/22 modules.zig-parse-number.parse_number.ParseNumber.parseFloatNumber...OK
Test 16/22 modules.zig-parse-number.parse_number.ParseNumber...OK
Test 17/22 modules.zig-parse-number.parse_number.ParseNumber.errors...OK
Test 18/22 modules.zig-parse-number.parse_number.ParseNumber.non-u8-sizes...OK
Test 19/22 modules.zig-parse-number.parse_number.ParseNumber.parseF32...OK
Test 20/22 modules.zig-parse-number.parse_number.ParseNumber.leading.zeros...OK
Test 21/22 modules.zig-parse-number.parse_number.ParseNumber.no.leading.digit...OK
Test 22/22 modules.zig-parse-number.parse_number.ParseNumber.trailing.decimal...OK
All tests passed.
```

## Clean
Remove `zig-cache/` directory
```bash
$ rm -rf test ./zig-cache/
```
