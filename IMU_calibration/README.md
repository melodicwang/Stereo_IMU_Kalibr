# 3. IMU_calibration
似乎是用 `imu_utils` 进行标定的。

## 3.1 采集数据
    IMU需要静止采集大概2个小时
```
rosbag record /imu0 -O imu.bag
```

## 3.2 标定
```
rosbag play -r 200 imu.bag

roslaunch imu_utils ZR300.launch
```

`ZR300.launch`
```
<launch>
    <node pkg="imu_utils" type="imu_an" name="imu_an" output="screen">
        <param name="imu_topic" type="string" value= "/camera/imu/data_raw"/>
        <param name="imu_name" type="string" value= "ZR300"/>
        <param name="data_save_path" type="string" value= "$(find imu_utils)/data/"/>
        <param name="max_time_min" type="int" value= "80"/>
        <param name="max_cluster" type="int" value= "100"/>
    </node>
</launch>
```


## 3.3 `imu.yaml`
```
#Accelerometers
accelerometer_noise_density: 2.52e-02   #Noise density (continuous-time)
accelerometer_random_walk:   4.41e-04   #Bias random walk

#Gyroscopes
gyroscope_noise_density:     2.78e-03   #Noise density (continuous-time)
gyroscope_random_walk:       1.65e-05   #Bias random walk

rostopic:                    /camera/imu/data_raw   #the IMU ROS topic
update_rate:                 200.0      #Hz (for discretization of the values above)
```