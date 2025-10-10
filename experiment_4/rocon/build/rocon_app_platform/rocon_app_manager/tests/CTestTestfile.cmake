# CMake generated Testfile for 
# Source directory: /home/haiden/rocon/src/rocon_app_platform/rocon_app_manager/tests
# Build directory: /home/haiden/rocon/build/rocon_app_platform/rocon_app_manager/tests
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_rocon_app_manager_nosetests_nosetests "/home/haiden/rocon/build/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/kinetic/share/catkin/cmake/test/run_tests.py" "/home/haiden/rocon/build/test_results/rocon_app_manager/nosetests-nosetests.xml" "--return-code" "\"/usr/bin/cmake\" -E make_directory /home/haiden/rocon/build/test_results/rocon_app_manager" "/usr/bin/nosetests-2.7 -P --process-timeout=60 --where=/home/haiden/rocon/src/rocon_app_platform/rocon_app_manager/tests/nosetests --with-xunit --xunit-file=/home/haiden/rocon/build/test_results/rocon_app_manager/nosetests-nosetests.xml")
subdirs(rostests)
