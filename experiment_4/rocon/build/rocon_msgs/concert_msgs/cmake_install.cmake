# Install script for directory: /home/haiden/rocon/src/rocon_msgs/concert_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/haiden/rocon/install")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/concert_msgs/msg" TYPE FILE FILES
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/ConcertClient.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/ConcertClients.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/ConcertClientState.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/ConductorGraph.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/ErrorCodes.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/LinkConnection.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/LinkEdge.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/LinkGraph.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/LinkNode.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/ServiceProfile.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/Services.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/SoftwareProfile.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/SoftwareProfiles.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/SoftwareInstance.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/SoftwareInstances.msg"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/msg/Strings.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/concert_msgs/srv" TYPE FILE FILES
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/srv/EnableService.srv"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/srv/UpdateServiceConfig.srv"
    "/home/haiden/rocon/src/rocon_msgs/concert_msgs/srv/AllocateSoftware.srv"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/concert_msgs/cmake" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/concert_msgs/catkin_generated/installspace/concert_msgs-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/include/concert_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/roseus/ros/concert_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/common-lisp/ros/concert_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/gennodejs/ros/concert_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/haiden/rocon/devel/lib/python2.7/dist-packages/concert_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/lib/python2.7/dist-packages/concert_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/concert_msgs/catkin_generated/installspace/concert_msgs.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/concert_msgs/cmake" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/concert_msgs/catkin_generated/installspace/concert_msgs-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/concert_msgs/cmake" TYPE FILE FILES
    "/home/haiden/rocon/build/rocon_msgs/concert_msgs/catkin_generated/installspace/concert_msgsConfig.cmake"
    "/home/haiden/rocon/build/rocon_msgs/concert_msgs/catkin_generated/installspace/concert_msgsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/concert_msgs" TYPE FILE FILES "/home/haiden/rocon/src/rocon_msgs/concert_msgs/package.xml")
endif()

