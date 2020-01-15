#!/bin/sh

#chmod +x filename

rosrun kalibr kalibr_calibrate_cameras \
	--bag /home/melodic/kalibr_workspace/stereo_calibra.bag \
	--topics /left /right \
	--models pinhole-equi pinhole-equi \
	--target /home/melodic/kalibr_workspace/april_7x4_50x50cm.yaml
