#!/usr/bin/env python

import rospy
from std_msgs.msg import Empty
import rosplan_dispatch_msgs.msg
import rosplan_knowledge_msgs.srv
from diagnostic_msgs.msg import KeyValue
from move_base_msgs.msg import *
import actionlib
import subprocess
import os.path
import sys
places = {
	"table_side2":[1.21, 0.9, -1.57],
	"table_side1":[1.15, 2.66, -1.57],
	"plate_pile" :[2.75, 1.0, 1.57],
	"cup_stack"  :[2.75,2.47, 1.57],
}
location = '/home/yotama/workplace/cogrob'

def callback(msg):
	print 'callback initiate\n', '\n'*5
	# initiate action feedback variable
	feedBack = rosplan_dispatch_msgs.msg.ActionFeedback()
	# grab the action name
	feedBack.action_id = msg.action_id
	feedBack.status = "action enabled"
	# initial action feedback update
	action_feedback_pub.publish(feedBack)
	# start move_to command
	if msg.name == 'move_to_object':
		for p in msg.parameters:
			print 'the p key is: ', p.key
			print 'the p value is: ', p.value
			if p.key == 'robot':
				robot = p.value
			elif p.key == 'oldplace':
				from_wp = p.value
			elif p.key == 'place':
				to_wp = p.value
		[x_cord, y_cord, w_cord] = places[to_wp]
		print 'x_cord, y_cord, w_cord are: ', x_cord, y_cord, w_cord
		# simple_move_client(x_cord, y_cord, robot)
		simple_move_client(x_cord, y_cord, w_cord, robot)
		# robotControl.robotMoveTo(from_wp, to_wp, robot)
		print '\n'*3
	if msg.name == 'pick_up_choice':
		while True:
			choice1=raw_input("What did the human pick up? (cup/plate): ")
			if choice1=="cup":
				subprocess.call(location + "/src/cup_plate/scripts/decisions/puc.sh",shell=True)
				break
			elif choice1=="plate":
				subprocess.call(location +"/src/cup_plate/scripts/decisions/pup.sh",shell=True)
				break
	if msg.name == 'put_down_choice':
		choice2=raw_input("Where did the human put down? (side1/side2): ")
		while True:
			if choice2=="side1":
				subprocess.call(location +"/src/cup_plate/scripts/decisions/pd1.sh",shell=True)
				break
			elif choice2=="side2":
				subprocess.call(location +"/src/cup_plate/scripts/decisions/pd2.sh",shell=True)
				break
	# if msg.name=='pick_up': 
	# if msg.name=='put_down': 
	# update and publish feedback variable
	feedBack = rosplan_dispatch_msgs.msg.ActionFeedback()
	feedBack.action_id = msg.action_id
	feedBack.status = "action achieved"
	action_feedback_pub.publish(feedBack)
	
def simple_move_client(x_pos = 0.0, y_pos = 0.0, w_pos= 0.0, robot = ''):
	print 'client initiate...'
	# initiate client varaiable
	print 'wait for movebase node:/move_base'
	client = actionlib.SimpleActionClient('/move_base', MoveBaseAction)
	print 'client is online !'
	# initiate goal varaiable
	goal = MoveBaseGoal()
	# set goal
	goal.target_pose.pose.position.x = x_pos
	goal.target_pose.pose.position.y = y_pos
	goal.target_pose.pose.orientation.w = w_pos
	goal.target_pose.header.frame_id = '/map'
	goal.target_pose.header.stamp = rospy.Time.now()
	# Waits until the action server is online
	client.wait_for_server()
	# send goal to client
	client.send_goal(goal)
	# wait for result
	client.wait_for_result()
	# print result
	print client.get_result()
	print 'DONE'

# initiate node
rospy.init_node("turtle_rosplan_interface")
# publish action feedback to /kcl_rosplan/action_feedback topic
action_feedback_pub = rospy.Publisher('/kcl_rosplan/action_feedback', rosplan_dispatch_msgs.msg.ActionFeedback, queue_size=10)
rospy.wait_for_service('/kcl_rosplan/update_knowledge_base')
# call to service /update_knowledge_base
update_kb = rospy.ServiceProxy('/kcl_rosplan/update_knowledge_base', rosplan_knowledge_msgs.srv.KnowledgeUpdateService)
# subscribe to action_dispatch server
rospy.Subscriber("/kcl_rosplan/action_dispatch", rosplan_dispatch_msgs.msg.ActionDispatch, callback)
# loop over ...
rospy.spin()
