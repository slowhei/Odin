package AudioToolbox

import "core:sys/darwin/CoreAudioTypes"

AudioUnitPropertyID :: u32
AudioUnitScope :: u32
AudioUnitElement :: u32

//TODO: with this bit_set, i decided to deviate from the C header file kAudioUnitRenderAction_ enum naming
//      is this confusing? should i create extra constants for easy ctrl+f?
AudioUnitRenderActionFlags :: bit_set[enum{
    PreRender            = 2,
    PostRender           = 3,
    OutputIsSilence      = 4,

    //TODO: is this Offline_ prefix helpful? or is it confusing?
    Offline_Preflight    = 5,
    Offline_Render       = 6,
    Offline_Complete     = 7,

    PostRenderError      = 8,
    DoNotCheckRenderArgs = 9,
}; u32]

AURenderCallback :: #type proc "c" (
    inRefCon:       rawptr,
    ioActionFlags:  ^AudioUnitRenderActionFlags,
    inTimeStamp:    ^CoreAudioTypes.AudioTimeStamp,
    inBusNumber:    u32,
    inNumberFrames: u32,
    ioData:         ^CoreAudioTypes.AudioBufferList,
) -> OSStatus
