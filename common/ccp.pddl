(define (domain ccp);;contingent cup plate, not chinese communist party
    (:requirements :strips :typing :disjunctive-preconditions)
    (:types thing place robot)
    (:predicates 
        (robot_at ?p - place)
        (has ?r - robot ?o - object)
        (sated)
        (robot_free)
        
        (is_plate_place ?p - place)
        (is_cup_place ?p - place)
        (is_table_1 ?p - place)
        (is_table_2 ?p - place)
        (cup ?o - object)
        (plate ?o - object)
        (human_get_cup)
        (human_get_plate)
        (human_put_1)
        (human_put_2)
    )
    (:action observe_get
        :parameters ()
        :precondition (and
            (robot_free)
        )
        :observe (human_get_cup)
    )
    (:action get_cup
        :parameters (?from - place ?cupp - place ?cup - object ?robot - robot)
        :precondition (and
            (human_get_plate)
            (is_cup_place ?cupp)
            (cup ?cup)
            (robot_at ?from)
        )
        :effect(and
            (has ?robot ?cup)
            (not (robot_free))
            (not (robot_at ?from))
            (robot_at ?cupp)
            
        )
    )
    (:action get_plate
        :parameters (?from - place ?platep - place ?plate - object ?robot - robot)
        :precondition (and
            (human_get_cup)
            (is_plate_place ?platep)
            (plate ?plate)
            (robot_at ?from)
        )
        :effect(and
            (has ?robot ?plate)
            (not (robot_free))
            (not (robot_at ?from))
            (robot_at ?platep)
            
        )
    )
    (:action observe_put
        :parameters (?o - object ?r - robot)
        :precondition(
            has ?r ?o
        )
        :observe(human_put_1)
    )
    (:action put1
        :parameters (?from - place ?tablep - place ?ob - object ?robot - robot)
        :precondition (and
            (human_put_2)
            (is_table_1 ?tablep)
            (has ?robot ?ob)
            (robot_at ?from)
        )
        :effect(and
            (robot_free)
            (not (robot_at ?from))
            (robot_at ?tablep)
            (not(has ?robot ?ob))
            (sated)
        )
    )
    (:action put2
        :parameters (?from - place ?tablep - place ?ob - object ?robot - robot)
        :precondition (and
            (human_put_1)
            (is_table_2 ?tablep)
            (has ?robot ?ob)
            (robot_at ?from)
        )
        :effect(and
            (robot_free)
            (not (robot_at ?from))
            (robot_at ?tablep)
            (not(has ?robot ?ob))
            (sated)
        )
    )
)