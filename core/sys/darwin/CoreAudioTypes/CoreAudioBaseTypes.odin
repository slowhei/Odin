package CoreAudioTypes

AudioBuffer :: struct{
    mNumberChannels: u32,
    mDataByteSize:   u32,
    mData:           rawptr,
}

AudioBufferList :: struct{
    mNumberBuffers: u32,
    //TODO: could i improve type safety in my bindings?
    mBuffers: [1]AudioBuffer, // this is a variable length array of mNumberBuffers elements
}

AudioFormatID :: u32
AudioFormatFlags :: u32

AudioStreamBasicDescription :: struct{
    mSampleRate:       f64,
    mFormatID:         AudioFormatID,
    mFormatFlags:      AudioFormatFlags,
    mBytesPerPacket:   u32,
    mFramesPerPacket:  u32,
    mBytesPerFrame:    u32,
    mChannelsPerFrame: u32,
    mBitsPerChannel:   u32,
    mReserved:         u32,
}

kAudioFormat :: enum AudioFormatID {
    LinearPCM               = 'l'<<24+'p'<<16+'c'<<8+'m',
    AC3                     = 'a'<<24+'c'<<16+'-'<<8+'3',
    _60958AC3                = 'c'<<24+'a'<<16+'c'<<8+'3',
    AppleIMA4               = 'i'<<24+'m'<<16+'a'<<8+'4',
    MPEG4AAC                = 'a'<<24+'a'<<16+'c'<<8+' ',
    MPEG4CELP               = 'c'<<24+'e'<<16+'l'<<8+'p',
    MPEG4HVXC               = 'h'<<24+'v'<<16+'x'<<8+'c',
    MPEG4TwinVQ             = 't'<<24+'w'<<16+'v'<<8+'q',
    MACE3                   = 'M'<<24+'A'<<16+'C'<<8+'3',
    MACE6                   = 'M'<<24+'A'<<16+'C'<<8+'6',
    ULaw                    = 'u'<<24+'l'<<16+'a'<<8+'w',
    ALaw                    = 'a'<<24+'l'<<16+'a'<<8+'w',
    QDesign                 = 'Q'<<24+'D'<<16+'M'<<8+'C',
    QDesign2                = 'Q'<<24+'D'<<16+'M'<<8+'2',
    QUALCOMM                = 'Q'<<24+'c'<<16+'l'<<8+'p',
    MPEGLayer1              = '.'<<24+'m'<<16+'p'<<8+'1',
    MPEGLayer2              = '.'<<24+'m'<<16+'p'<<8+'2',
    MPEGLayer3              = '.'<<24+'m'<<16+'p'<<8+'3',
    TimeCode                = 't'<<24+'i'<<16+'m'<<8+'e',
    MIDIStream              = 'm'<<24+'i'<<16+'d'<<8+'i',
    ParameterValueStream    = 'a'<<24+'p'<<16+'v'<<8+'s',
    AppleLossless           = 'a'<<24+'l'<<16+'a'<<8+'c',
    MPEG4AAC_HE             = 'a'<<24+'a'<<16+'c'<<8+'h',
    MPEG4AAC_LD             = 'a'<<24+'a'<<16+'c'<<8+'l',
    MPEG4AAC_ELD            = 'a'<<24+'a'<<16+'c'<<8+'e',
    MPEG4AAC_ELD_SBR        = 'a'<<24+'a'<<16+'c'<<8+'f',
    MPEG4AAC_ELD_V2         = 'a'<<24+'a'<<16+'c'<<8+'g',
    MPEG4AAC_HE_V2          = 'a'<<24+'a'<<16+'c'<<8+'p',
    MPEG4AAC_Spatial        = 'a'<<24+'a'<<16+'c'<<8+'s',
    MPEGD_USAC              = 'u'<<24+'s'<<16+'a'<<8+'c',
    AMR                     = 's'<<24+'a'<<16+'m'<<8+'r',
    AMR_WB                  = 's'<<24+'a'<<16+'w'<<8+'b',
    Audible                 = 'A'<<24+'U'<<16+'D'<<8+'B',
    iLBC                    = 'i'<<24+'l'<<16+'b'<<8+'c',
    DVIIntelIMA             = 0x6D730011,
    MicrosoftGSM            = 0x6D730031,
    AES3                    = 'a'<<24+'e'<<16+'s'<<8+'3',
    EnhancedAC3             = 'e'<<24+'c'<<16+'-'<<8+'3',
    FLAC                    = 'f'<<24+'l'<<16+'a'<<8+'c',
    Opus                    = 'o'<<24+'p'<<16+'u'<<8+'s',
    APAC                    = 'a'<<24+'p'<<16+'a'<<8+'c',
}

//TODO: i left out a lot of them
kAudioFormatFlag :: bit_set[enum{
    IsFloat          = 0,
    IsBigEndian      = 1,
    IsSignedInteger  = 2,
    IsPacked         = 3,
    IsAlignedHigh    = 4,
    IsNonInterleaved = 5,
    IsNonMixable     = 6,
}; AudioFormatFlags]

//TODO: chose to deviate from naming convention
SMPTETimeType :: enum u32 {
    _24        = 0,
    _25        = 1,
    _30Drop    = 2,
    _30        = 3,
    _2997      = 4,
    _2997Drop  = 5,
    _60        = 6,
    _5994      = 7,
    _60Drop    = 8,
    _5994Drop  = 9,
    _50        = 10,
    _2398      = 11
}

//TODO: deviated from C naming
SMPTETimeFlags :: bit_set[enum{
    Valid   = 0,
    Running = 1,
}; u32]
//TODO: this is kind of messy
kSMPTETimeUnknown :: SMPTETimeFlags{}

SMPTETime :: struct{
    mSubframes:       i16,
    mSubframeDivisor: i16,
    mCounter:         u32,
    mType:            SMPTETimeType,
    mFlags:           SMPTETimeFlags,
    mHours:           i16,
    mMinutes:         i16,
    mSeconds:         i16,
    mFrames:          i16,
}

AudioTimeStampFlags :: bit_set[enum{
    SampleTimeValid      = 0,
    HostTimeValid        = 1,
    RateScalarValid      = 2,
    WordClockTimeValid   = 3,
    SMPTETimeValid       = 4,
}; u32]
//TODO: because one of the constants has two high bits, i'm making extra constants
//      this might be the way to go for the rest of the API
kAudioTimeStampNothingValid        :: AudioTimeStampFlags{}
kAudioTimeStampSampleTimeValid     :: AudioTimeStampFlags{.SampleTimeValid}
kAudioTimeStampHostTimeValid       :: AudioTimeStampFlags{.HostTimeValid}
kAudioTimeStampRateScalarValid     :: AudioTimeStampFlags{.RateScalarValid}
kAudioTimeStampWordClockTimeValid  :: AudioTimeStampFlags{.WordClockTimeValid}
kAudioTimeStampSMPTETimeValid      :: AudioTimeStampFlags{.SMPTETimeValid}
kAudioTimeStampSampleHostTimeValid :: AudioTimeStampFlags{.SampleTimeValid, .HostTimeValid}

AudioTimeStamp :: struct{
    mSampleTime:    f64,
    mHostTime:      u64,
    mRateScalar:    f64,
    mWordClockTime: u64,
    mSMPTETime:     SMPTETime,
    mFlags:         AudioTimeStampFlags,
    mReserved:      u32,
};
