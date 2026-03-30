package objc_GameController

import    "base:intrinsics"
import NS "core:sys/darwin/Foundation"

msgSend          :: intrinsics.objc_send
dispatch_queue_t :: NS.dispatch_queue_t



@(require)
foreign import "system:GameController.framework"

@(default_calling_convention="c", link_prefix="GC")
foreign GameController {
    ProductCategoryDualSense:                  ^NS.String
    ProductCategoryDualShock4:                 ^NS.String
    ProductCategoryMFi:                        ^NS.String
    ProductCategoryXboxOne:                    ^NS.String
    ProductCategoryArcadeStick:                ^NS.String
    ProductCategoryHID:                        ^NS.String

    ProductCategorySiriRemote1stGen:           ^NS.String
    ProductCategorySiriRemote2ndGen:           ^NS.String
    ProductCategoryControlCenterRemote:        ^NS.String
    ProductCategoryUniversalElectronicsRemote: ^NS.String
    ProductCategoryCoalescedRemote:            ^NS.String

    ProductCategoryMouse:                      ^NS.String
    ProductCategoryKeyboard:                   ^NS.String

    ProductCategorySpatialStylus:              ^NS.String
    ProductCategorySpatialController:          ^NS.String



    MouseDidConnectNotification:          ^NS.String
    MouseDidDisconnectNotification:       ^NS.String
    MouseDidBecomeCurrentNotification:    ^NS.String
    MouseDidStopBeingCurrentNotification: ^NS.String
}



@(objc_class="GCDevice")
Device :: struct{using _: NS.Object}

@(objc_type=Device, objc_name="vendorName")
Device_vendorName :: proc "c" (self: ^Device) -> ^NS.String {
    return msgSend(^NS.String, self, "vendorName")
}

@(objc_type=Device, objc_name="productCategory")
Device_productCategory :: proc "c" (self: ^Device) -> ^NS.String {
    return msgSend(^NS.String, self, "productCategory")
}

@(objc_type=Device, objc_name="handlerQueue")
Device_handlerQueue :: proc "c" (self: ^Device) -> dispatch_queue_t {
    return msgSend(dispatch_queue_t, self, "handlerQueue")
}
@(objc_type=Device, objc_name="setHandlerQueue")
Device_setHandlerQueue :: proc "c" (self: ^Device, queue: dispatch_queue_t) {
    msgSend(dispatch_queue_t, self, "setHandlerQueue:", queue)
}



@(objc_class="GCPhysicalInputProfile")
PhysicalInputProfile :: struct{using _: NS.Object}

@(objc_type=PhysicalInputProfile, objc_name="device")
PhysicalInputProfile_device :: proc "c" (self: ^PhysicalInputProfile) -> ^Device {
    return msgSend(^Device, self, "device")
}

//TODO: more bindings



@(objc_class="GCMouseInput")
MouseInput :: struct{using _: PhysicalInputProfile}

@(objc_type=MouseInput, objc_name="mouseMovedHandler")
MouseInput_mouseMovedHandler :: proc "c" (self: ^MouseInput) -> MouseMoved {
    return msgSend(MouseMoved, self, "mouseMovedHandler")
}

@(objc_type=MouseInput, objc_name="setMouseMovedHandler")
MouseInput_setMouseMovedHandler :: proc "c" (self: ^MouseInput, mouseMovedHandler: MouseMoved) {
    msgSend(nil, self, "setMouseMovedHandler:", mouseMovedHandler)
}

MouseMoved :: ^Objc_Block(proc "c" (mouse: ^MouseInput, deltaX: f32, deltaY: f32))

//TODO: test
@(objc_type=MouseInput, objc_name="leftButton")
MouseInput_leftButton :: proc "c" (self: ^MouseInput) -> ^ControllerButtonInput {
    return msgSend(^ControllerButtonInput, self, "leftButton")
}

//TODO: test
@(objc_type=MouseInput, objc_name="rightButton")
MouseInput_rightButton :: proc "c" (self: ^MouseInput) -> ^ControllerButtonInput {
    return msgSend(^ControllerButtonInput, self, "rightButton")
}

//TODO: test
@(objc_type=MouseInput, objc_name="middleButton")
MouseInput_middleButton :: proc "c" (self: ^MouseInput) -> ^ControllerButtonInput {
    return msgSend(^ControllerButtonInput, self, "middleButton")
}

//TODO: test
@(objc_type=MouseInput, objc_name="auxiliaryButtons")
MouseInput_auxiliaryButtons :: proc "c" (self: ^MouseInput) -> ^NS.Array {
    return msgSend(^NS.Array, self, "auxiliaryButtons")
}

//TODO: test
@(objc_type=MouseInput, objc_name="scroll")
MouseInput_scroll :: proc "c" (self: ^MouseInput) -> ^DeviceCursor {
    return msgSend(^DeviceCursor, self, "scroll")
}



@(objc_class="GCControllerElement")
ControllerElement :: struct{using _: NS.Object}
//TODO: bindings

@(objc_class="GCControllerAxisInput")
ControllerAxisInput :: struct{using _: ControllerElement}
@(objc_type=ControllerAxisInput, objc_name="value")
ControllerAxisInput_value :: proc "c" (self: ^ControllerAxisInput) -> f32 {
    return msgSend(f32, self, "value")
}
@(objc_type=ControllerAxisInput, objc_name="setValue")
ControllerAxisInput_setValue :: proc "c" (self: ^ControllerAxisInput, value: f32) {
    msgSend(nil, self, "setValue:", value)
}
@(objc_type=ControllerAxisInput, objc_name="valueChangedHandler")
ControllerAxisInput_valueChangedHandler :: proc "c" (self: ^ControllerAxisInput) -> ControllerAxisValueChangedHandler {
    return msgSend(ControllerAxisValueChangedHandler, self, "valueChangedHandler")
}
@(objc_type=ControllerAxisInput, objc_name="setValueChangedHandler")
ControllerAxisInput_setValueChangedHandler :: proc "c" (self: ^ControllerAxisInput, valueChangedHandler: ControllerAxisValueChangedHandler) {
    msgSend(ControllerAxisValueChangedHandler, self, "setValueChangedHandler:", valueChangedHandler)
}

ControllerAxisValueChangedHandler :: ^Objc_Block(proc "c" (axis: ^ControllerAxisInput, value: f32))



@(objc_class="GCControllerButtonInput")
ControllerButtonInput :: struct{using _: ControllerElement}
//todo: bindings



@(objc_class="GCControllerDirectionPad")
ControllerDirectionPad :: struct{using _: ControllerElement}
//TODO: more bindings
@(objc_type=ControllerDirectionPad, objc_name="xAxis")
ControllerDirectionPad_xAxis :: proc "c" (self: ^ControllerElement) -> ^ControllerAxisInput {
    return msgSend(^ControllerAxisInput, self, "xAxis")
}
@(objc_type=ControllerDirectionPad, objc_name="yAxis")
ControllerDirectionPad_yAxis :: proc "c" (self: ^ControllerElement) -> ^ControllerAxisInput {
    return msgSend(^ControllerAxisInput, self, "yAxis")
}



@(objc_class="GCDeviceCursor")
DeviceCursor :: struct{using _: ControllerDirectionPad}
//todo: bindings



@(objc_class="GCMouse")
Mouse :: struct{using _: Device}

@(objc_type=Mouse, objc_name="mice", objc_is_class_method=true)
Mouse_mice :: proc "c" () -> ^NS.Array {
    return msgSend(^NS.Array, Mouse, "mice")
}

@(objc_type=Mouse, objc_name="current", objc_is_class_method=true)
Mouse_current :: proc "c" () -> ^Mouse {
    return msgSend(^Mouse, Mouse, "current")
}

@(objc_type=Mouse, objc_name="mouseInput")
Mouse_mouseInput :: proc "c" (self: ^Mouse) -> ^MouseInput {
    return msgSend(^MouseInput, self, "mouseInput")
}
