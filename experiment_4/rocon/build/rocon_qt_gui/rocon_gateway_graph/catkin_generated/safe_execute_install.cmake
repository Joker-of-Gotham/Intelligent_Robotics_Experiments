execute_process(COMMAND "/home/haiden/rocon/build/rocon_qt_gui/rocon_gateway_graph/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/haiden/rocon/build/rocon_qt_gui/rocon_gateway_graph/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
