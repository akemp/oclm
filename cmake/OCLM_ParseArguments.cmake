# Copyright (c) 2007-2012 Hartmut Kaiser
# Copyright (c) 2011      Bryce Lelbach
# Copyright (c) 2010-2011 Alexander Neundorf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

set(OCLM_PARSEARGUMENTS_LOADED TRUE)

include(OCLM_Include)

oclm_include(ListContains)

macro(oclm_parse_arguments prefix arg_names option_names)
  set(DEFAULT_ARGS)

  foreach(arg_name ${arg_names})
    set(${prefix}_${arg_name})
  endforeach()

  foreach(option ${option_names})
    set(${prefix}_${option} FALSE)
  endforeach()

  set(current_arg_name DEFAULT_ARGS)
  set(current_arg_list)

  foreach(arg ${ARGN})
    oclm_list_contains(is_arg_name ${arg} ${arg_names})
    if(is_arg_name)
      set(${prefix}_${current_arg_name} ${current_arg_list})
      set(current_arg_name ${arg})
      set(current_arg_list)
    else()
      oclm_list_contains(is_option ${arg} ${option_names})
      if(is_option)
        set(${prefix}_${arg} TRUE)
      else()
        set(current_arg_list ${current_arg_list} ${arg})
      endif()
    endif()
  endforeach()

  set(${prefix}_${current_arg_name} ${current_arg_list})
endmacro()

