(define (problem table_problem)
	(:domain table-setting)
	(:objects plate_pile cup_stack table_side1 table_side2 - place
			robot1 - robot
			cup plate - thing)
	(:init  
		(robot_at table_side1)
; 		(human_at table_side1)
		(is_thing_place plate plate_pile)
		(is_thing_place cup cup_stack)
		(is_table_place table_side1)
		(is_table_place table_side2)
		; (is_table_place table_middle)
		(free robot1)
	)
	(:goal (robot_at table_side2))
)
