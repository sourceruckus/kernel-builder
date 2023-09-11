Source Ruckus Kernel-Builder - build that kernel like a wizard!
===============================================================

Copyright 2018-2023 Michael D Labriola <veggiemike@sourceruckus.org>

Licensed under the GPLv3. See the file COPYING for details. 

The Source Ruckus Kernel-Builder is a utility for automating building the Linux
kernel, creating a universal initrd using RuckusRD, and wrapping it all up into
a self-extracting kernel installer.  The resulting installer can be installed
locally or can install itself on a list of remote hosts via SSH.

Get the latest and greatest from https://github.com/sourceruckus/kernel-builder.

<pre>
Execute this inside an already configured (e.g., via make menuconfig) kernel
source tree.

usage: kernel-builder OPTIONS...

  -h, --help                Show this help message and exit.

  -V, --version             Show version string and exit.

  -K, --kernel-only         Just compile the kernel and install its files in
                            $PWD/FOO.

  -k, --kernel-and-initrd   Stop after generating the initrd via RuckusRD and
                            installing it in $PWD/FOO/boot.  Basically, stop
                            before creating the installer.  This can be usefull
                            for testing new kernel configurations before you're
                            really ready to install and/or distribute the
                            kernel.

  -n, --numjobs=N           Use N jobs for compiling.  Default is CPUCOUNT+1,
                            which should peg CPU usage at 100% on most systems
                            and result in the fastest build times.  If you want
                            to use less CPU and let the compilation take more
                            time, specify a smaller value for N with this
                            option.

  -s, --stable              Build 'stable' kernel.  This results in /boot files
                            being named with a trailing .y instead of the point
                            release number, so you don't have to update the
                            bootloader config after installation.  There's also
                            a .y symlink in /lib/modules and /usr/src pointing
                            to the appropriately versioned directories as well
                            as installation code to move the symlink and remove
                            old files.  The idea here is that installing 5.10.42
                            should completely replace all of 5.10.41's files and
                            require only a simple reboot w/out any other
                            reconfiguration to get into the new kernel.

  -t, --test                Build 'test' kernel.  These kernels have 'test' in
                            filenames instead of a version string.  This option
                            is for facilitating quick bisect jobs, where you're
                            compiling different kernel versions and rebooting
                            over and over w/out having to reconfigure the
                            bootloader every single time.
</pre>
