#!/bin/sh

#chmod +x filename


kalibr_calibrate_imu_camera \
	--target /home/melodic/kalibr_workspace/april_7x4_50x50cm.yaml \
	--cam /home/melodic/kalibr_workspace/stereo_calibra.yaml \
	--imu /home/melodic/kalibr_workspace/imu_mynteye.yaml \
	--bag /home/melodic/kalibr_workspace/stereo_imu_calibra.bag \
	--bag-from-to 2 37