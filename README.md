Source Ruckus Kernel-Builder - build that kernel like a wizard
==============================================================

Copyright 2018-2022 Michael D Labriola <veggiemike@sourceruckus.org>

Licensed under the GPLv3. See the file COPYING for details. 

Kernel-Builder is a utility for creating compressed, self extracting
executables that run an embedded install script after extracting to a
temp directory.

Get the latest and greatest from https://github.com/sourceruckus/kernel-builder.

<pre>
usage: extractenator OPTIONS PAYLOAD...

  -f, --filename EXEFILE    Specify output filename. (REQUIRED)

  -e, --exclude PATTERN     Exclude files in PAYLOAD that match PATTERN,
                            a glob(3)-style wildcard pattern.  Can be
                            specified multiple times.

  -s, --script SCRIPT       Specify installation script to be run after
                            extraction.  SCRIPT will be included as archive
                            content, you don't have to also specify it as
                            payload. (REQUIRED)

  -c, --compressor COMP     Use COMP compressor in pipeline during archive
                            creation.  See extracenator.conf for details on
                            valid compressors and defaults.

  -C, --compressor-args ARGS  Pass ARGS into the specified compressor.  If
                              --compressor was specified, defaults to the
                              matching COMP_ARGS variable in extractenator.conf.
                              Can be provided multiple times, causing argurments
                              to be appended (i.e., becaue you cannot have
                              spaces in ARGS).

  -V, --version             Show version string and exit.
</pre>
