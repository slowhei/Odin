#+build darwin
package darwin

import "core:c"

timespec :: struct{
	tv_sec:  __darwin_time_t,
	tv_nsec: c.long,
}

//TODO: maybe alias to u32 instead? i replace UInt32 with u32 everywhere in my bindings
UInt32 :: c.uint

//TODO: these types are not part of the kernel_data_types API collection, but whatever, they can live here for now:
//      https://developer.apple.com/documentation/kernel/ostype
OSType :: FourCharCode
FourCharCode :: c.uint

//TODO: Everything else in https://developer.apple.com/documentation/kernel/kernel_data_types
