#include <stdio.h>
#include <JavaScriptCore/JavaScript.h>

JSValueRef Log(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argumentCount, const JSValueRef arguments[], JSValueRef * exception) {
    for(size_t i = 0; i < argumentCount; i++) {
        JSStringRef strig = JSValueToStringCopy(context, arguments[i], NULL);
        size_t bufferSize = JSStringGetMaximumUTF8CStringSize(strig);
        char buffer[bufferSize];
        JSStringGetUTF8CString(strig, buffer, bufferSize);
        printf("%s", buffer);
        JSStringRelease(strig);
    }

    printf("\n");
    return JSValueMakeUndefined(context);
}

void consoleLogFunction(JSContextRef context, JSObjectRef globaObject) {
    JSStringRef consoleName = JSStringCreateWithUTF8CString("console");
    JSObjectRef consoleObject = JSObjectMake(context, NULL, NULL);
    JSObjectSetProperty(context, globaObject, consoleName, consoleObject, kJSPropertyAttributeNone, NULL);

    JSStringRef logFunctionName = JSStringCreateWithUTF8CString("log");

    JSObjectRef logFunctionObject = JSObjectMakeFunctionWithCallback(context, logFunctionName, Log);
    JSObjectSetProperty(context, consoleObject, logFunctionName, logFunctionObject, kJSPropertyAttributeNone, NULL);

    JSStringRelease(consoleName);
    JSStringRelease(logFunctionName);

}