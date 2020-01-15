## imu_utils installation

依赖项 **ceres** **libdw-dew**
```
sudo apt-get install libdw-dev
```


## build
编译步骤如下：
- 1. 编译 `code_utils`
- 2. 再编译 `imu_utils` ( `imu_utils` 是 `catkin_make` 包，需要 `code_utils` 支持)
- 3. 再编译 `vio_data_simulation-ros`
	包要一个一个添加进去。


### 1. `code_utils`

（https://github.com/gaowenliang/code_utils）



`code_utils-master` 编译之前需要在 `CMakeLists.txt` 中需要包含：

```
include_directories("include/code_utils")
```

在根目录下新建文件夹运行：
```
mkdir imu_utils_workspace/src
cd imu_utils_workspace/src
git clone https://github.com/gaowenliang/code_utils
cd ..
catkin_make
```

### 2. `imu_utils`
```
cd ~/imu_utils_workspace/src
git clone https://github.com/gaowenliang/imu_utils.git
cd ..
catkin_make
```

### 3. `vio_data_simultation-ros_version`
```
cd ~/imu_utils_workspace/src
git clone https://github.com/HeYijia/vio_data_simulation-ros_version // 手动下载
git checkout ros_version
cd ..
catkin_make
```


## run

修改 `gener_alldata` 下面的 `imu.bag` 路径为相对路径 `./imu.bag`

倍速播放 `imu.bag`
```
rosbag play -r 200 imu.bag
```

关于roslaunch: 如果用Github提供的bag就不用改，如果是自己的IMU，就根据IMU的 `name` 和 `topic` 改。

把 `roslaunch imu_utils A3.launch` 中的 `A3.launch` 替换为`16448.launch` 就行了，`name` 和 `topic` 去 `16448.launch` 里面看。


### 错误：
```
The specified base path "/home/melodic/imu_utils_workspace/src" contains a CMakeLists.txt
but "catkin_make" must be invoked in the root of workspace
```

解决办法：`unlink CMakeLists.txt`


## 参考资料

[IMU噪声标定——加速度计和陀螺仪的白噪声和零偏不稳定性](https://blog.csdn.net/learning_tortosie/article/details/89878769)

[VIO第二讲_allen方差工具](https://www.cnblogs.com/wongyi/p/11057900.html)
