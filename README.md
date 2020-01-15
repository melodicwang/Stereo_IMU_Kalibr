## Camera-IMU_calibration with MYNTEYE-S1030 by Kalibr



## 1. Kalibr Installation


## 2. Prepare the Apriltag
生成 `Aprilgrid` 标定板
```
kalibr_create_target_pdf --type apriltag --nx 7 --ny 4 --tsize [0.05] --tspace 0.2
```

`Aprilgrid.yaml`
```
target_type: 'aprilgrid' #gridtype
tagCols: 7               #number of apriltags
tagRows: 6               #number of apriltags
tagSize: 0.088           #size of apriltag, edge to edge [m]
tagSpacing: 0.3          #ratio of space between tags to tagSize

#example: tagSize=2m, spacing=0.5m --> tagSpacing=0.25[-]
```


## 3. Camera_calibration
### 3.1 修改话题发布频率
- 查看话题
```
rostopic list
```

- 修改话题发布频率
```
rosrun topic_tools throttle messages /mynteye/left/image_raw 4.0 /left

rosrun topic_tools throttle messages /mynteye/right/image_raw 4.0 /right
```

- 显示图像话题
```
rqt_image_view

rosrun image_view image_view image:=/left/image_raw &

rosrun image_view image_view image:=/right/image_raw &
```



### 3.2 录制 `rosbag`
录制相机左右目图像2个话题
```
rosbag record -O stereo_calibra.bag /left /right
```

### 3.3 标定
```
rosrun kalibr kalibr_calibrate_cameras \
	--bag /home/melodic/kalibr_workspace/stereo_calibra.bag \
	--topics /left /right \
	--models pinhole-equi pinhole-equi \
	--target /home/melodic/kalibr_workspace/april_7x4_50x50cm.yaml
```


## 4. IMU_calibration



## 5. Cam_IMU_calibration

### 5.1 录制数据
    用相机对准标定板，pitch 三次，yaw 三次，roll 三次，up and down 三次，左右三次，然后随意运动。

    注意：录制时间要小于60S。
```
rosbag record -O stereo_imu_calibra.bag \
	/mynteye/left/image_raw \
	/mynteye/right/image_raw \
	/mynteye/imu/data_raw
```

### 5.2 标定
```
kalibr_calibrate_imu_camera \
	--target /home/melodic/kalibr_workspace/april_7x4_50x50cm.yaml \
	--cam /home/melodic/kalibr_workspace/stereo_calibra.yaml \
	--imu /home/melodic/kalibr_workspace/imu_mynteye.yaml \
	--bag /home/melodic/kalibr_workspace/stereo_imu_calibra.bag \
	--bag-from-to 2 37
```


## 6. 参考资料
	Kalibr标定双目内外参数以及IMU外参数
	https://blog.csdn.net/heyijia0327/article/details/83583360

	https://blog.csdn.net/zhubaohua_bupt/article/details/80222321

	使用Kalibr标定Davis 240c（单目+IMU）【完整版】
	https://www.cnblogs.com/wongyi/p/11152062.html

	Calibrating the VI Sensor
	https://github.com/ethz-asl/kalibr/wiki/calibrating-the-vi-sensor
