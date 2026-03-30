#+build darwin
// Bindings for [[ CoreVideo ; https://developer.apple.com/documentation/corevideo ]].
package darwin_CoreVideo

CVSMPTETime :: struct {
	sbuframes: i16,
	subframeDivisor: i16,
	count: u32,
	type: u32,
	flags: u32,
	hours: i16,
	minutes: i16,
	seconds: i16,
	frames: i16,
}

