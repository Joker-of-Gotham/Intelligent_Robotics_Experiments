# Install script for directory: /home/haiden/rocon/src/rocon_msgs/gateway_msgs

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gateway_msgs/msg" TYPE FILE FILES
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/ConnectionStatistics.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/ConnectionType.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/GatewayInfo.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/RemoteGateway.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/RemoteRule.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/RemoteRuleWithStatus.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/ErrorCodes.msg"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/msg/Rule.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gateway_msgs/srv" TYPE FILE FILES
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/Advertise.srv"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/AdvertiseAll.srv"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/ConnectHub.srv"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/Remote.srv"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/RemoteAll.srv"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/RemoteGatewayInfo.srv"
    "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/srv/SetWatcherPeriod.srv"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gateway_msgs/cmake" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/gateway_msgs/catkin_generated/installspace/gateway_msgs-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/include/gateway_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/roseus/ros/gateway_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/common-lisp/ros/gateway_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/gennodejs/ros/gateway_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/haiden/rocon/devel/lib/python2.7/dist-packages/gateway_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/lib/python2.7/dist-packages/gateway_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/gateway_msgs/catkin_generated/installspace/gateway_msgs.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gateway_msgs/cmake" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/gateway_msgs/catkin_generated/installspace/gateway_msgs-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gateway_msgs/cmake" TYPE FILE FILES
    "/home/haiden/rocon/build/rocon_msgs/gateway_msgs/catkin_generated/installspace/gateway_msgsConfig.cmake"
    "/home/haiden/rocon/build/rocon_msgs/gateway_msgs/catkin_generated/installspace/gateway_msgsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gateway_msgs" TYPE FILE FILES "/home/haiden/rocon/src/rocon_msgs/gateway_msgs/package.xml")
endif()

