# This function is used to force a build on a dependant project at cmake
# configuration phase.

# FOLLOWING ARGUMENTS are the CMAKE_ARGS of ExternalProject_Add
function (build_external_project source_dir target repository tag)
  message(STATUS "Building in: ${source_dir}")
  # mktemp dir in build tree
  file(MAKE_DIRECTORY ${source_dir} ${source_dir}/build)
  # generate false dependency project
  set(CMAKE_LIST_CONTENT "
  cmake_minimum_required(VERSION 2.8)

  include(ExternalProject)
  ExternalProject_add(${target}
          PREFIX ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME}
          GIT_REPOSITORY ${repository}
          GIT_TAG ${tag}
          CMAKE_ARGS ${ARGN}
          INSTALL_COMMAND \"\"
          TIMEOUT 20)
          add_custom_target(trigger_${target})
          add_dependencies(trigger_${target} ${target})")

  file(WRITE ${source_dir}/CMakeLists.txt "${CMAKE_LIST_CONTENT}")

  execute_process(COMMAND ${CMAKE_COMMAND} -DCMAKE_VERBOSE_MAKEFILE=ON -G Ninja ..
                  WORKING_DIRECTORY ${source_dir}/build)
  message(STATUS "Using ninja to build GTSAM. May take a while. Please be patient.")
  execute_process(COMMAND ${CMAKE_COMMAND} --build .
                  WORKING_DIRECTORY ${source_dir}/build)

endfunction()
