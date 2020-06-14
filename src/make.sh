export CPLUS_INCLUDE_PATH=/usr/local/cuda-10.0/targets/x86_64-linux/include
cmake -DCMAKE_BUILD_TYPE=Release -DCAFFE_ROOT_DIR=/home/blair/phd/robocup/caffe/ -DHFO_ROOT_DIR=/home/blair/phd/robocup/HFO/ ..

# Other commands:
# ln -s /home/blair/phd/robocup/caffe/build/install/include/caffe/proto/
