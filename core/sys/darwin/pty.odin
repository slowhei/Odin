#+build darwin
package darwin

import "core:c"
import "core:sys/posix"
import "vendor:darwin/libc" //TODO: it's kind of backwards for a core package to import a vendor package

foreign import "system:util"

foreign util {
    openpty :: proc(
        amaster: ^c.int,
        aslave:  ^c.int,
        name:    cstring,
        termp:   ^posix.termios,
        winp:    ^libc.winsize,
    ) -> c.int ---
}
