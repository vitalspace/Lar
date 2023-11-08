const std = @import("std");
const jsc = @import("../jsc/jsc.zig");
const fng = @import("../function_generator/function_generator.zig");

export fn Add(context: jsc.JSContextRef, globalObject: jsc.JSObjectRef, thisObject: jsc.JSObjectRef, argumentsCount: usize, arguments: [*c]const jsc.JSValueRef, execption: [*c]jsc.JSValueRef) callconv(.C) jsc.JSValueRef {
    _ = execption;
    _ = thisObject;
    _ = globalObject;

    if (argumentsCount < 2) {
        std.debug.print("The function requires 2 aguments\n", .{});
        return jsc.JSValueMakeUndefined(context);
    }

    var numa = jsc.JSValueToNumber(context, arguments[0], null);
    var numb = jsc.JSValueToNumber(context, arguments[1], null);

    var add = numa + numb;
    // std.debug.print("{d}\n", .{add});
    return jsc.JSValueMakeNumber(context, add);
}

pub fn Apis(context: jsc.JSContextRef, globalObject: jsc.JSObjectRef) !void {
    try fng.createCustomFunction(context, globalObject, "Add", Add);
}
