cmake_minimum_required(VERSION 2.8.3)
project(gtsam_catkin)

include(cmake_modules/IncludeProject.cmake)

set(GTSAM_PREFIX gtsam)
set(GTSAM_GIT_REPO https://bitbucket.org/gtborg/gtsam.git)

if(NOT GIT_TAG)
  set(GIT_TAG develop)
endif()

message(STATUS ${GIT_TAG})

set(SOURCE_DIR ${CATKIN_DEVEL_PREFIX}/lib/${GTSAM_PREFIX}/force_${GIT_TAG})
build_external_project(
    ${SOURCE_DIR}
    ${GTSAM_PREFIX}
    ${GTSAM_GIT_REPO}
    ${GIT_TAG})

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

file(GLOB_RECURSE GTSAM_LIBS
    ${CATKIN_DEVEL_PREFIX}/libgtsam.so
)

set(GTSAM_INCLUDE_DIRS
    ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME}/src/${GTSAM_PREFIX}-build/)

catkin_package(
    INCLUDE_DIRS ${GTSAM_INCLUDE_DIRS}
    LIBRARIES ${GTSAM_LIBS}
)

message(STATUS "INCLUDE_DIRS: ${GTSAM_INCLUDE_DIRS}")
message(STATUS "LIBRARIES: ${GTSAM_LIBS}")

# in your other catkin projects the g2o libraries will be available as:
# ${gtsam_catkin_INCLUDE_DIRS}
# ${gtsam_catkin_LIBRARIES}
