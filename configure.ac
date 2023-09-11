AC_PREREQ([2.65])

m4_define(kb_major_version, 1)
m4_define(kb_minor_version, 0)
m4_define(kb_micro_version, 1)
m4_define(kb_devtag, [])
m4_ifnblank(kb_devtag,
	[m4_define(kb_version, kb_major_version.kb_minor_version.kb_micro_version-kb_devtag)],
	[m4_define(kb_version, kb_major_version.kb_minor_version.kb_micro_version)])

AC_INIT([Source Ruckus Kernel-Builder], [kb_version], [veggiemike@sourceruckus.org], [kernel-builder])
AC_CONFIG_AUX_DIR([.])
#AC_CONFIG_MACRO_DIR([m4])

AC_SUBST(KB_MAJOR_VERSION, kb_major_version)
AC_SUBST(KB_MINOR_VERSION, kb_minor_version)
AC_SUBST(KB_MICRO_VERSION, kb_micro_version)
AC_SUBST(KB_DEVTAG, kb_devtag)

AM_INIT_AUTOMAKE([dist-xz no-dist-gzip tar-pax foreign subdir-objects color-tests])

AC_PROG_INSTALL
AC_PROG_MKDIR_P
AC_PROG_LN_S

# check for sed /w --in-place
#
# NOTE: Using sed -i in makefiles is frowned upon because it's not
#       portable.  We make 'sed -i' a requirement and check for it here
#       because... I like it and I think pretty much everyone has it.  But
#       I do want to get bonked upside the head if it's going to cause
#       problems.
#
AC_PROG_SED
AS_TMPDIR(kb-)
AC_CACHE_CHECK([whether $ac_cv_path_SED supports -i], [kb_cv_sed_i],
  [AS_IF([touch $tmp/sed && $ac_cv_path_SED -i 's|||' $tmp/sed 2>/dev/null],
      kb_cv_sed_i=yes,
      kb_cv_sed_i=no)])
rm -f $tmp/sed && rmdir $tmp
if test $kb_cv_sed_i != yes; then
    AC_MSG_ERROR([Kb requires sed -i])
fi

# check for needed programs
AC_DEFUN([NEEDED_PROGS],
	 [dnl needed at build-time
	  help2man
	  dnl needed at run-time
	  bash
	  ruckusrd
	  extractenator
	  tar
	  find
	  make
	 ])

m4_foreach_w([P], NEEDED_PROGS,
  [AC_PATH_PROG(m4_bpatsubst(m4_toupper(P), [\.], [_]), P)
   AS_IF([test "$m4_bpatsubst(m4_toupper(P), [\.], [_])" = ""],
     AC_MSG_ERROR([Could not find P]))
  ])


AC_CONFIG_FILES([Makefile
		 src/Makefile
		 src/kernel-builder.sh
		 ])
AC_OUTPUT


# Create a fully expanded variable out of one with embedded path variables.
#
# NOTE: This might not be the best way to fully expand the variable, but it
#       works for me.  It might be portable.  It might not.  Fingers
#       crossed.
#
# NOTE: This only works if we make sure $prefix has been set already...
#       otherwise we end up with NONE in our path.
#
expandit()
{
  test "$prefix" = "NONE" && prefix=/usr/local
  result=$1
  while :; do
    temp=`eval echo $result`
    test "$temp" = "$result" && break
    result=$temp
  done
  echo $result
}


echo
echo
echo
echo "------------------------------------------------------------------------"
echo "$PACKAGE_STRING"
echo "------------------------------------------------------------------------"
echo
echo "Configuration Options Summary:"
echo
echo "Installation:"
echo "  prefix...............: $prefix"
echo "  pkgdatadir...........: `expandit $datadir/$PACKAGE_TARNAME`"
echo
