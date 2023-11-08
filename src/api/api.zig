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

///*
//* Registers APIs within the provided JavaScript context and global object.
//*
//* @param context       The JavaScript context where the APIs will be registered.
//* @param globalObject  The global object to which the APIs will be added.
//*
//* @return              There is no explicit return value.
//*/

pub fn Apis(context: jsc.JSContextRef, globalObject: jsc.JSObjectRef) !void {
    // Attempts to create a custom function "Add" and add it to the provided context and global object
    try fng.createCustomFunction(context, globalObject, "Add", Add); 
}
