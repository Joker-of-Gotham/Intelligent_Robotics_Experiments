# Install script for directory: /home/haiden/kobuki/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/haiden/kobuki/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/haiden/kobuki/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/haiden/kobuki/install" TYPE PROGRAM FILES "/home/haiden/kobuki/build/catkin_generated/installspace/_setup_util.py")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/haiden/kobuki/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/haiden/kobuki/install" TYPE PROGRAM FILES "/home/haiden/kobuki/build/catkin_generated/installspace/env.sh")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/haiden/kobuki/install/setup.bash;/home/haiden/kobuki/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/haiden/kobuki/install" TYPE FILE FILES
    "/home/haiden/kobuki/build/catkin_generated/installspace/setup.bash"
    "/home/haiden/kobuki/build/catkin_generated/installspace/local_setup.bash"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/haiden/kobuki/install/setup.sh;/home/haiden/kobuki/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/haiden/kobuki/install" TYPE FILE FILES
    "/home/haiden/kobuki/build/catkin_generated/installspace/setup.sh"
    "/home/haiden/kobuki/build/catkin_generated/installspace/local_setup.sh"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/haiden/kobuki/install/setup.zsh;/home/haiden/kobuki/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/haiden/kobuki/install" TYPE FILE FILES
    "/home/haiden/kobuki/build/catkin_generated/installspace/setup.zsh"
    "/home/haiden/kobuki/build/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/haiden/kobuki/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/haiden/kobuki/install" TYPE FILE FILES "/home/haiden/kobuki/build/catkin_generated/installspace/.rosinstall")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/haiden/kobuki/build/gtest/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_capabilities/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_core/kobuki_core/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_desktop/kobuki_desktop/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_core/kobuki_ftdi/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_desktop/kobuki_gazebo/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_rapps/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_desktop/kobuki_rviz_launchers/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_core/kobuki_dock_drive/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_core/kobuki_driver/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_msgs/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_keyop/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_auto_docking/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_bumper2pc/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_desktop/kobuki_dashboard/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_desktop/kobuki_gazebo_plugins/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_description/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_ar_pair_approach/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_cmd_vel_mux/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_controllers/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_controller_tutorial/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_random_walker/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_safety_controller/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_keyop/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_localization_manager/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_math_toolkit/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_ar_marker_tracking/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_diff_drive_pose_controller/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yocs_msgs/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_ar_pair_tracking/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_joyop/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_navi_toolkit/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_navigator/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_rapps/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_safety_controller/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_velocity_smoother/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_node/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki/kobuki_testsuite/cmake_install.cmake")
  include("/home/haiden/kobuki/build/kobuki_desktop/kobuki_qtestsuite/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_virtual_sensor/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_waypoint_provider/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yocs_waypoints_navi/cmake_install.cmake")
  include("/home/haiden/kobuki/build/yujin_ocs/yujin_ocs/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/haiden/kobuki/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
