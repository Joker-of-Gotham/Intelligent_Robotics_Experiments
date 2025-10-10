# Install script for directory: /home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rocon_interaction_msgs/msg" TYPE FILE FILES
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/ErrorCodes.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/Interaction.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/InteractiveClient.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/InteractiveClients.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/Pairing.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/PairingStatus.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/RemoconStatus.msg"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/msg/Strings.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rocon_interaction_msgs/srv" TYPE FILE FILES
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/GetInteraction.srv"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/GetInteractions.srv"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/GetPairings.srv"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/RequestInteraction.srv"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/SetInteractions.srv"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/StartPairing.srv"
    "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/srv/StopPairing.srv"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rocon_interaction_msgs/cmake" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/rocon_interaction_msgs/catkin_generated/installspace/rocon_interaction_msgs-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/include/rocon_interaction_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/roseus/ros/rocon_interaction_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/common-lisp/ros/rocon_interaction_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/share/gennodejs/ros/rocon_interaction_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/haiden/rocon/devel/lib/python2.7/dist-packages/rocon_interaction_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/haiden/rocon/devel/lib/python2.7/dist-packages/rocon_interaction_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/rocon_interaction_msgs/catkin_generated/installspace/rocon_interaction_msgs.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rocon_interaction_msgs/cmake" TYPE FILE FILES "/home/haiden/rocon/build/rocon_msgs/rocon_interaction_msgs/catkin_generated/installspace/rocon_interaction_msgs-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rocon_interaction_msgs/cmake" TYPE FILE FILES
    "/home/haiden/rocon/build/rocon_msgs/rocon_interaction_msgs/catkin_generated/installspace/rocon_interaction_msgsConfig.cmake"
    "/home/haiden/rocon/build/rocon_msgs/rocon_interaction_msgs/catkin_generated/installspace/rocon_interaction_msgsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rocon_interaction_msgs" TYPE FILE FILES "/home/haiden/rocon/src/rocon_msgs/rocon_interaction_msgs/package.xml")
endif()

