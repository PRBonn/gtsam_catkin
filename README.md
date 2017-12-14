# GTSAM meets Catkin #
The package is a wrapper around GTSAM to allow using it easily with Catkin.

## Funtionality ##
It features a CMake script that carries out main functions:
- downloads specified GTSAM tag from GitHub repository (newest `develop` by
  default)
- exports GTSAM includes, so they are available as
  `${gtsam_catkin_INCLUDE_DIRS}` for other catkin packages.
- exports GTSAM libraries, so they are available as `${gtsam_catkin_LIBRARIES}`
  for other catkin packages.

## How to use? ##
Just clone it to your catkin workspace and run:
- `catkin build gtsam_catkin`

Alternatively, you can run cmake from source:
- `mkdir build`
- `cd build`
- `cmake ..`

Also, you can pass git tag if you want to (version 3.2.1):
- `cmake -DGIT_TAG=3c1d2746a80e ..`

**It downloads and builds GTSAM. It takes a lot of time, so have patience.**

## Some details ##
This package does all the work in CMake phase. The reason for this is that we
need to have access to all libraries built by GTSAM by the time we reach the
end of `CMakeLists.txt` stored in this repository. There is no need to build
(read: run `make` on) this repository as it does not define any new targets.
