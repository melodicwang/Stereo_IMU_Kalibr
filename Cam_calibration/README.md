# 2. Camera_calibration

## 2.1 Prepare the Aprilgrid

[Download](https://github.com/ethz-asl/kalibr/wiki/calibration-targets)

	kalibr 提供三种类型标定板下载 ———— Aprilgrid, Checkerboard, Circlegrid。

	Aprilgrid 能提供序号信息, 防止姿态计算时出现跳跃的情况, 建议采用Aprilgrid进行标定。

	将电脑屏幕当成标定板时，选择能在显示屏上100%显示尺寸的标定板。


[Generate](https://github.com/ethz-asl/kalibr/wiki/calibration-targets)
```
kalibr_create_target_pdf --type apriltag --nx 7 --ny 4 --tsize [0.05] --tspace 0.2

kalibr_create_target_pdf --type apriltag --nx [NUM_COLS 列数] --ny [NUM_ROWS 行数] \
	--tsize [TAG_WIDTH_M] --tspace [TAG_SPACING_PERCENT]
```


## 2.2 标定板参数文件 `Aprilgrid.yaml`
```
target_type: 'aprilgrid' #gridtype
tagCols: 7               #number of apriltags
tagRows: 6               #number of apriltags
tagSize: 0.088           #size of apriltag, edge to edge [m]
tagSpacing: 0.3          #ratio of space between tags to tagSize

#example: tagSize=2m, spacing=0.5m --> tagSpacing=0.25[-]
```


## 2.3 录制数据
	为了得到好的标定结果，应该使得标定板尽量出现在摄像头视野的各个位置里。

	操作如下：
    用相机对准标定板，pitch 三次，yaw 三次，roll 三次，up and down 三次，左右三次，然后随意运动。

    注意：录制时间要小于60S。

1. ROS 提供了改变 topic 发布频率的节点throttle, 指令如下 :
```
rosrun topic_tools throttle messages /mynteye/left/image_raw 4.0 /left

rosrun topic_tools throttle messages /mynteye/right/image_raw 4.0 /right
```

2. 对左右目的ros topic降低频率后就可以制作bag了
```
rosbag record -O stereo_calibra.bag /left /right
```



## 2.4 转换数据
在连续时间获得的拍摄标定版的图像和IMU数据包，需要自己采集后再利用 kalibr 提供的工具转化成.bag包。（似乎可不做，主要是那个 python 脚本在 18.04 下着实不好用。）
```
kalibr_bagcreater --folder dataset-dir --output-bag awsome.bag

说明：
	dataset-dir是数据输入路径：其内文件结构应是这样:
		/cam0/image_raw
		/cam1/image_raw
		/imu0
	awsome.bag 是制作好的bag文件。默认输出在kalibr_bagcreater同目录下。
```


## 2.5 run
MYNT-EYE-S 是 kannala_brandt 模型，在标定的时候选择 pinhole-equi 针孔+等距模型。
```
rosrun kalibr kalibr_calibrate_cameras \
	--bag /home/melodic/kalibr_workspace/stereo_calibra.bag \
	--topics /left /right \
	--models pinhole-equi pinhole-equi \
	--target /home/melodic/kalibr_workspace/april_7x4_50x50cm.yaml
```


## 2.6 输出数据

	1.report-imucam-%BAGNAME%.pdf
		Report in PDF format. Contains all plots for documentation.

	2.results-imucam-%BAGNAME%.txt
		Result summary as a text file.

	3.camchain-imucam-%BAGNAME%.yaml
		在输入文件camchain.yaml基础上增加了标定后的cam-imu信息的结果文件。T_cam_imu矩阵就在这里。
