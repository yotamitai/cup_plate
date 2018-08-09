# cup_plate
Cognitive Robotics project in intent recognition and plan adaptation using ROSPlan and Turtlebot robot

the following package requires rosplan that can be found at:
https://github.com/KCL-Planning/ROSPlan
the required version of rosplan can be found in the hydro branch

occupancy grid that can be found at:
https://github.com/clearpathrobotics/occupancy_grid_utils


## to run
CREATING LOCAL WORKSPACE:
1) create workspace folder in home directory
2) copy src folder of package into workspace directory
4) run from terminal:
	cd workspace
	source /opt/ros/kinetic/setup.bash
	catkin_make

	
LOCAL SETUP:
1) navigate to workspace/src/cup_plate/scripts
2) open cpd_real.py and cpd_sim.py
3) modify the "location" variable in to your workspace directory address
4) halt monngodb process:
	sudo service mongodb stop (to turn on later replace 'stop' with 'start')

----------------REAL_ROBOT---------------------

** required ip's:

of local computer = <local_ip>
  
of turtlebot = <turtlebot_ip>

1) open 5 terminals

2) connect 2 of them to the turtlebot through ssh:

		ssh turtlebot@<turtlebot_ip>
    
3) connect the 3 others to the turtlebot ROS Master:

		hostname -I
    
		export ROS_IP=<local_ip>
    
		export ROS_MASTER_URI=http://<turtlebot_ip>:11311
    
		cd workspace		
    
		source devel/setup.bash
    
4) in ssh terminal 1:

		roslaunch turtlebot_bringup minimal.launch
    
5) in not-ssh terminal 1:

		roslaunch cup_plate cup_plate_real.launch 
    
6) in ssh terminal 2:

		roslaunch turtlebot_navigation amcl_demo.launch map_file:=/home/turtlebot/room2.yaml initial_pose_x:=1.5 initial_pose_y:=2.2 initial_pose_a:=0.0

7) in not-ssh terminal 2:

		roslaunch turtlebot_rviz_launchers view_navigation.launch --screen
    
8) in not-ssh terminal 3:

		source src/main.sh
    
9) answer questions in bot-ssh terminal 1  


** map file must be located on robot.

you can use the following command to transport a map to the robot:

		rsync -avz ./room.* turtlebot@<turtlebot_ip>:/home/turtlebot/
    

----------------SIMULATION---------------------
1) open 3 terminals

2) cd workspace

3) source devel/setup.bash

4) in terminal 1:

	 	roslaunch cup_plate cup_plate_sim.launch
    
5) in terminal 2:

	  	source src/main.sh
      
5*) optional: (to see in Rviz)

in terminal 3:
   
	 	roslaunch turtlebot_rviz_launchers view_navigation.launch --screen
    
6) in terminal 1 answer the questions
