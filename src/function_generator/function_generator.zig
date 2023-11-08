const jsc = @import("../jsc/jsc.zig");

pub fn createCustomFunction(context: jsc.JSContextRef, globalObject: jsc.JSObjectRef, functionName: []const u8, functionCallback: jsc.JSObjectCallAsFunctionCallback) !void {
    const functionString = jsc.JSStringCreateWithUTF8CString(functionName.ptr);
    const functionObject = jsc.JSObjectMakeFunctionWithCallback(context, functionString, functionCallback);
    jsc.JSObjectSetProperty(context, globalObject, functionString, functionObject, jsc.kJSPropertyAttributeNone, null);
    jsc.JSStringRelease(functionString);
}
