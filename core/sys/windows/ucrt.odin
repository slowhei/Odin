package sys_windows

import "core:c"

//TODO: i don't know if core:sys/windows is the right place to do this
//      i feel like people will be upset with me if i force them to link with the CRT
foreign import "system:libucrt.lib"

@(default_calling_convention="c")
foreign libucrt {
    _open_osfhandle :: proc(_OSFileHandle: c.intptr_t, _Flags: c.int) -> c.int ---
}
