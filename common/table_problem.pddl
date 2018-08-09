(define (problem table_problem)
(:domain table_domain)
(:objects
    plate_pile cup_stack table_side1 table_side2 - place
    robot1 - robot
    cup plate - thing
)
(:init
    (free robot1)
    (is_table_place table_side1)
    (is_table_place table_side2)
    (is_thing_place plate plate_pile)
    (is_thing_place cup cup_stack)
    (open plate_pile)
    (open cup_stack)
    (open table_side1)
    (open table_side2)
    (robot_at table_side1)
)
(:goal (and
    (made_pu_decision)
)))
