//TODO: some decisions I made:
//      don't use types like UInt32. just directly use u32

#+build darwin
package AudioToolbox

import "core:sys/darwin"
import "core:sys/darwin/CoreServices"

@(require)
foreign import "system:AudioToolbox.framework"

@(default_calling_convention="c")
foreign AudioToolbox {
    AudioComponentFindNext :: proc(
        inComponent: AudioComponent,
        inDesc:      ^AudioComponentDescription,
    ) -> AudioComponent ---

    AudioComponentInstanceNew :: proc(
        inComponent: AudioComponent,
        outInstance: ^AudioComponentInstance,
    ) -> OSStatus ---

    AudioOutputUnitStart :: proc(ci: AudioUnit) -> OSStatus ---

    AudioUnitInitialize :: proc(inUnit: AudioUnit) -> OSStatus ---

    //TODO: could avoid casting from enum to u32 at the call site if the binding takes an enum as parameter
    //      but i don't know if that's a good idea yet. it feels like some of these enum cases definitions are split
    //      across frameworks
    //TODO: inData and inDataSize could benefit from some Odin compile time size stuff
    //      don't know if it's worth it though
    AudioUnitSetProperty :: proc(
        inUnit:     AudioUnit,
        inID:       AudioUnitPropertyID,
        inScope:    AudioUnitScope,
        inElement:  AudioUnitElement,
        inData:     rawptr,
        inDataSize: u32,
    ) -> OSStatus ---
}

//TODO: is there a better way to cast a 4CC to int in Odin?
kAudioUnitType :: enum darwin.UInt32 {
	Output            = darwin.UInt32('a'<<24+'u'<<16+'o'<<8+'u'),
	MusicDevice       = darwin.UInt32('a'<<24+'u'<<16+'m'<<8+'u'),
	MusicEffect       = darwin.UInt32('a'<<24+'u'<<16+'m'<<8+'f'),
	FormatConverter   = darwin.UInt32('a'<<24+'u'<<16+'f'<<8+'c'),
	Effect            = darwin.UInt32('a'<<24+'u'<<16+'f'<<8+'x'),
	Mixer             = darwin.UInt32('a'<<24+'u'<<16+'m'<<8+'x'),
	Panner            = darwin.UInt32('a'<<24+'u'<<16+'p'<<8+'n'),
	Generator         = darwin.UInt32('a'<<24+'u'<<16+'g'<<8+'n'),
	OfflineEffect     = darwin.UInt32('a'<<24+'u'<<16+'o'<<8+'l'),
	MIDIProcessor     = darwin.UInt32('a'<<24+'u'<<16+'m'<<8+'i'),
	SpeechSynthesizer = darwin.UInt32('a'<<24+'u'<<16+'s'<<8+'p'),
}

//TODO: i left out a lot of enum cases
kAudioUnitSubType :: enum darwin.UInt32 {
    GenericOutput     = darwin.UInt32('g'<<24+'e'<<16+'n'<<8+'r'),
    VoiceProcessingIO = darwin.UInt32('v'<<24+'p'<<16+'i'<<8+'o'),

	Sampler   = darwin.UInt32('s'<<24+'a'<<16+'m'<<8+'p'),
	MIDISynth = darwin.UInt32('m'<<24+'s'<<16+'y'<<8+'n'),
//TODO: when not iphone {
    HALOutput     = darwin.UInt32('a'<<24+'h'<<16+'a'<<8+'l'),
    DefaultOutput = darwin.UInt32('d'<<24+'e'<<16+'f'<<8+' '),
    SystemOutput  = darwin.UInt32('s'<<24+'y'<<16+'s'<<8+' '),
    DLSSynth      = darwin.UInt32('d'<<24+'l'<<16+'s'<<8+' '),
//TODO: } else {
    RemoteIO = darwin.UInt32('r'<<24+'i'<<16+'o'<<8+'c'),
//TODO: }
}

kAudioUnitManufacturer :: enum darwin.UInt32 {
    Apple = darwin.UInt32('a'<<24+'p'<<16+'p'<<8+'l'),
}

AudioComponent :: ^OpaqueAudioComponent

AudioComponentDescription :: struct{
    componentType:         darwin.OSType,
    componentSubType:      darwin.OSType,
    componentManufacturer: darwin.OSType,
    componentFlags:        darwin.UInt32,
    componentFlagsMask:    darwin.UInt32,
}

when ODIN_PLATFORM_SUBTARGET_IOS {
    //TODO:
    // AudioComponentInstance 
} else {
    AudioComponentInstance :: ^CoreServices.ComponentInstanceRecord
}

AudioUnit :: AudioComponentInstance

OpaqueAudioComponent :: struct{} // opaque type

//TODO: this comes from MacTypes.h
//      i guess it falls under the CoreServices framework?
//      or maybe it goes in core:sys/darwin?
//
//      also, it's defined in SecBase.odin of core:sys/darwin/Security right now
//      should fix that
OSStatus :: i32
