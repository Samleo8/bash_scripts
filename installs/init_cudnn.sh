# USAGE
# Initialises CUDNN. Needs to be run from a directory containing the downloaded CUDNN folder

echo "Copying ./include/cudnn.h to /usr/local/cuda/include ..."
sudo cp ./include/cudnn.h /usr/local/cuda/include
echo "Copied!"
echo "Copying ./lib64/libcudnn* to /usr/local/cuda/lib64 ..."
sudo cp ./lib64/libcudnn* /usr/local/cuda/lib64
echo "Copied!"
echo "Setting permissions..."
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
echo "CUDNN Initialization complete!"

echo "Performing test to verify init..."
cd cudnn_samples_v7/mnistCUDNN
make clean && make
./mnistCUDNN
