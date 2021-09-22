divert(-1)

###############################################################
# 8085 CPU USER CONFIGURATION
# rebuild the library if changes are made
#

# Class of 8085 being targeted

define(`__8085', 0x01)

# CPU info

define(`__CPU_INFO', 0x00)
define(`__CPU_INFO_ENABLE_UNDOCUMENTED', 0x01)

#
# END OF USER CONFIGURATION
###############################################################

divert(0)

dnl#
dnl# COMPILE TIME CONFIG EXPORT FOR ASSEMBLY LANGUAGE
dnl#

ifdef(`CFG_ASM_PUB',
`
PUBLIC `__8085'

PUBLIC `__CPU_INFO'
PUBLIC `__CPU_INFO_ENABLE_UNDOCUMENTED'
')

dnl#
dnl# LIBRARY BUILD TIME CONFIG FOR ASSEMBLY LANGUAGE
dnl#

ifdef(`CFG_ASM_DEF',
`
defc `__Z80' = __8085


defc `__CPU_INFO' = __CPU_INFO
defc `__CPU_INFO_ENABLE_UNDOCUMENTED' = __CPU_INFO_ENABLE_UNDOCUMENTED
')

dnl#
dnl# COMPILE TIME CONFIG EXPORT FOR C
dnl#

ifdef(`CFG_C_DEF',
`
`#undef'  `__8085'
`#define' `__8085'  __8085

`#define' `__CPU_INFO'  __CPU_INFO
`#define' `__CPU_INFO_ENABLE_UNDOCUMENTED'  __CPU_INFO_ENABLE_UNDOCUMENTED
')
