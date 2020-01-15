## [Kalibr Installation](https://github.com/ethz-asl/kalibr/wiki/installation)

**Prerequisite**

	ubuntu 18.04
	ROS melodic
	numpy
	eigen3
	opencv


## 1. Install the build and run dependencies
```
sudo apt install \
	python-pyx python-scipy python-setuptools python-matplotlib python-git python-pip \
	python-rosinstall python-catkin-tools ipython doxygen software-properties-common \
	libboost-all-dev libpoco-dev libtbb-dev libblas-dev liblapack-dev libv4l-dev \
	ros-melodic-vision-opencv ros-melodic-image-transport-plugins ros-melodic-cmake-modules

sudo pip3 install python-igraph --upgrade

pip3 install Cython
```


## 2. 创建ROS工作空间

```
mkdir -p ~/kalibr_workspace/src
cd ~/kalibr_workspace
source /opt/ros/melodic/setup.bash
catkin init
catkin config --extend /opt/ros/melodic
catkin config --merge-devel
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
```


## 3. Clone the source repository
```
cd ~/kalibr_workspace/src
git clone https://github.com/ethz-asl/Kalibr.git
```

	https://github.com/ethz-asl/kalibr/wiki/installation

	Kalibr工程有两种：
	1.CDE package,已经编译好的包，安装简单，不需要依赖ROS，但功能不全。
	2.未经编译的源文件，安装稍麻烦，但功能全，建议安装这种。


## 4. Build the code using the Release configuration.
```
cd ~/kalibr_workspace
catkin build -DCMAKE_BUILD_TYPE=Release -j8

source ~/kalibr_workspace/devel/setup.bash
```


## 5. Test
- 生成标定板
```
kalibr_create_target_pdf --type apriltag --nx 7 --ny 4 --tsize 0.05 --tspace 0.2

kalibr_create_target_pdf --type apriltag --nx [NUM_COLS 列数] --ny [NUM_ROWS 行数] \
	--tsize [TAG_WIDTH_M] --tspace [TAG_SPACING_PERCENT 0-1.0]
```


## 6. log

### 1. NO module named scipy.optimize
```
sudo apt install python-scipy
```

### 2. NO module named pyx
```
sudo apt install python-pyx
```

### 3. ImportError: cannot import name NavigationToolbar2Wx
```
  File "/home/melodic/kalibr_workspace/src/Kalibr/Schweizer-Messer/sm_python/python/sm/PlotCollection.py", line 8, in <module>
    from matplotlib.backends.backend_wxagg import NavigationToolbar2Wx as Toolbar
ImportError: cannot import name NavigationToolbar2Wx
```
	修改 `PlotCollection.py`文件
```
from matplotlib.backends.backend_wxagg import NavigationToolbar2WxAgg as Toolbar
```

### 4. ImportError: No module named Image
```
  File "/home/melodic/kalibr_workspace/src/Kalibr/aslam_offline_calibration/kalibr/python/kalibr_camera_calibration/MulticamGraph.py", line 12, in <module>
    import Image
ImportError: No module named Image
```
	修改`MulticamGraph.py`文件
```
from PIL import Image
```
