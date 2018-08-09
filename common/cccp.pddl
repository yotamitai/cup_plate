(define (problem cccp);;Союз Советских Социалистических Республик
    (:domain ccp)
    (:objects
        cup plate - object
        table_side1 table_side2 plate_pile cup_stack - place
        robot1 - robot
    )
    (:init
        (robot_free)
        (robot_at table_side1)
        (cup cup)
        (plate plate)
        (is_plate_place plate_pile)
        (is_cup_place cup_stack) 
        (is_table_1 table_side1)
        (is_table_2 table_side2)
        (unknown (human_get_cup))
        (unknown (human_get_plate))
        (oneof
            (human_get_cup)
            (human_get_plate)
        )
        (unknown (human_put_1))
        (unknown (human_put_2))
        (oneof
            (human_put_1)
            (human_put_2)
        )
    )
    (:goal
        (sated)
    )
)