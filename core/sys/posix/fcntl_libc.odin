#+build linux, windows, darwin, netbsd, openbsd, freebsd
package posix

when ODIN_OS == .Darwin {

	O_CLOEXEC   :: 0x01000000
	O_CREAT     :: 0x00000200
	O_DIRECTORY :: 0x00100000
	O_EXCL      :: 0x00000800
	O_NOCTTY    :: 0x00020000
	O_NOFOLLOW  :: 0x00000100
	O_TRUNC     :: 0x00000400

	_O_TTY_INIT :: 0
	O_TTY_INIT  :: O_Flags{}

	O_APPEND   :: 0x00000008
	O_DSYNC    :: 0x00400000
	O_NONBLOCK :: 0x00000004
	O_SYNC     :: 0x0080

	_O_RSYNC :: 0
	O_RSYNC  :: O_Flags{}

	O_EXEC   :: 0x40000000
	O_RDONLY :: 0
	O_RDWR   :: 0x0002
	O_WRONLY :: 0x0001

	_O_SEARCH :: O_EXEC | O_DIRECTORY
	O_SEARCH  :: O_Flags{.EXEC, .DIRECTORY}

} else when ODIN_OS == .FreeBSD {

	O_CLOEXEC   :: 0x00100000
	O_CREAT     :: 0x0200
	O_DIRECTORY :: 0x00020000
	O_EXCL      :: 0x0800
	O_NOCTTY    :: 0x8000
	O_NOFOLLOW  :: 0x0100
	O_TRUNC     :: 0x0400

	_O_TTY_INIT :: 0x00080000
	O_TTY_INIT  :: O_Flags{O_Flag_Bits(log2(_O_TTY_INIT))}

	O_APPEND   :: 0x0008
	O_DSYNC    :: 0x01000000
	O_NONBLOCK :: 0x0004
	O_SYNC     :: 0x0080
	_O_RSYNC   :: 0
	O_RSYNC    :: O_Flags{} // NOTE: not defined in headers

	O_EXEC   :: 0x00040000
	O_RDONLY :: 0
	O_RDWR   :: 0x0002
	O_WRONLY :: 0x0001

	_O_SEARCH :: O_EXEC
	O_SEARCH  :: O_Flags{ .EXEC }

} else when ODIN_OS == .NetBSD {

	O_CLOEXEC   :: 0x00400000
	O_CREAT     :: 0x0200
	O_DIRECTORY :: 0x0020000
	O_EXCL      :: 0x0800
	O_NOCTTY    :: 0x8000
	O_NOFOLLOW  :: 0x0100
	O_TRUNC     :: 0x0400

	_O_TTY_INIT :: 0
	O_TTY_INIT  :: O_Flags{} // NOTE: not defined in the headers

	O_APPEND   :: 0x0008
	O_DSYNC    :: 0x010000
	O_NONBLOCK :: 0x0004
	O_SYNC     :: 0x0080

	_O_RSYNC :: 0x0002
	O_RSYNC  :: O_Flags{O_Flag_Bits(log2(_O_RSYNC))}

	O_EXEC   :: 0x04000000
	O_RDONLY :: 0
	O_RDWR   :: 0x0002
	O_WRONLY :: 0x0001

	_O_SEARCH :: 0x00800000
	O_SEARCH  :: O_Flags{O_Flag_Bits(log2(_O_SEARCH))}

} else when ODIN_OS == .OpenBSD {

	O_CLOEXEC   :: 0x10000
	O_CREAT     :: 0x0200
	O_DIRECTORY :: 0x20000
	O_EXCL      :: 0x0800
	O_NOCTTY    :: 0x8000
	O_NOFOLLOW  :: 0x0100
	O_TRUNC     :: 0x0400

	_O_TTY_INIT :: 0
	O_TTY_INIT  :: O_Flags{} // NOTE: not defined in the headers

	O_APPEND   :: 0x0008
	O_DSYNC    :: 0x010000
	O_NONBLOCK :: 0x0004
	O_SYNC     :: 0x0080

	_O_RSYNC :: O_SYNC
	O_RSYNC  :: O_Flags{.SYNC}

	O_EXEC   :: 0x04000000 // NOTE: not defined in the headers
	O_RDONLY :: 0
	O_RDWR   :: 0x0002
	O_WRONLY :: 0x0001

	_O_SEARCH :: 0
	O_SEARCH  :: O_Flags{} // NOTE: not defined in the headers

} else when ODIN_OS == .Haiku {

	O_CLOEXEC   :: 0x00000040
	O_CREAT     :: 0x0200
	O_DIRECTORY :: 0x00200000
	O_EXCL      :: 0x0100
	O_NOCTTY    :: 0x1000
	O_NOFOLLOW  :: 0x00080000
	O_TRUNC     :: 0x0400

	_O_TTY_INIT :: 0
	O_TTY_INIT  :: O_Flags{} // NOTE: not defined in the headers

	O_APPEND   :: 0x0800
	O_DSYNC    :: 0x040000
	O_NONBLOCK :: 0x0080
	O_SYNC     :: 0x010000
	O_RSYNC    :: 0x020000

	O_EXEC   :: 0x04000000 // NOTE: not defined in the headers
	O_RDONLY :: 0
	O_RDWR   :: 0x0002
	O_WRONLY :: 0x0001

	_O_SEARCH :: 0
	O_SEARCH  :: O_Flags{} // NOTE: not defined in the headers

} else when ODIN_OS == .Linux {

	O_CREAT     :: 0o0_000_100
	O_EXCL      :: 0o0_000_200
	O_NOCTTY    :: 0o0_000_400
	O_TRUNC     :: 0o0_001_000
	O_DIRECTORY :: 0o0_200_000
	O_NOFOLLOW  :: 0o0_400_000
	O_CLOEXEC   :: 0o2_000_000

	_O_TTY_INIT :: 0
	O_TTY_INIT  :: O_Flags{}

	O_APPEND   :: 0o0_002_000
	O_NONBLOCK :: 0o0_004_000
	O_DSYNC    :: 0o0_010_000
	O_SYNC     :: 0o4_010_000

	_O_RSYNC :: 0
	O_RSYNC  :: O_Flags{}

	O_EXEC   :: 0x04000000 // NOTE: not defined in the headers

	O_RDONLY :: 0
	O_WRONLY :: 0o1
	O_RDWR   :: 0o2

	_O_SEARCH :: 0
	O_SEARCH  :: O_Flags{}

} else when ODIN_OS == .Windows {

	O_RDONLY      :: 0x0000  // open for reading only
	O_WRONLY      :: 0x0001  // open for writing only
	O_RDWR        :: 0x0002  // open for reading and writing
	O_APPEND      :: 0x0008  // writes done at eof

	O_CREAT       :: 0x0100  // create and open file
	O_TRUNC       :: 0x0200  // open and truncate
	O_EXCL        :: 0x0400  // open only if file doesn't already exist

	// O_TEXT files have <cr><lf> sequences translated to <lf> on read()'s and <lf>
	// sequences translated to <cr><lf> on write()'s

	O_TEXT        :: 0x4000  // file mode is text (translated)
	O_BINARY      :: 0x8000  // file mode is binary (untranslated)
	O_WTEXT       :: 0x10000 // file mode is UTF16 (translated)
	O_U16TEXT     :: 0x20000 // file mode is UTF16 no BOM (translated)
	O_U8TEXT      :: 0x40000 // file mode is UTF8  no BOM (translated)

	// macro to translate the C 2.0 name used to force binary mode for files
	O_RAW :: O_BINARY

	O_NOINHERIT   :: 0x0080  // child process doesn't inherit file
	O_TEMPORARY   :: 0x0040  // temporary file bit (file is deleted when last handle is closed)
	O_SHORT_LIVED :: 0x1000  // temporary storage file, try not to flush
	O_OBTAIN_DIR  :: 0x2000  // get information about a directory
	O_SEQUENTIAL  :: 0x0020  // file access is primarily sequential
	O_RANDOM      :: 0x0010  // file access is primarily random

}
