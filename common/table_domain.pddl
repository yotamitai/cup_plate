(define (domain table_domain)
	(:requirements :strips :typing :equality :durative-actions)
        (:types 
                place robot thing 
        )       
	(:predicates 
                (robot_at ?p - place)
                (is_table_place ?p - place)
                (is_thing_place ?t - thing ?p - place)
                (has ?t - thing ?p - robot)
                (on ?t - thing ?p - place)
                (free ?p - robot)
                (open ?p - place)
                (made_pu_decision ?r - robot)
                (made_pd_decision ?r - robot)
                (sated ?r - robot)
	)
        (:durative-action pick_up_choice
                :parameters (?robot - robot)
                :duration (= ?duration 1)
                :effect (and
                        (at end (made_pu_decision ?robot))
                )
        )
        (:durative-action put_down_choice
                :parameters (?robot - robot ?thing - thing)
                :duration (= ?duration 1)
                :condition (at start(has ?thing ?robot))
                :effect (and
                        (at end (made_pd_decision ?robot))
                )
        )
	(:durative-action move_to_object
		:parameters (?place - place ?oldplace - place ?robot - robot)
                :duration (= ?duration 20)
		:condition(and
		          (at start (robot_at ?oldplace))
                          (at start (open ?place))
                )
		:effect (and (at end (robot_at ?place))
		         (at start (not (robot_at ?oldplace)))
                        )
	)
	(:durative-action pick_up
                :parameters (?robot - robot ?place - place ?thing - thing )
                :duration (= ?duration 5)
                :condition(and 
                        (at start (made_pu_decision ?robot))
                        (at start (robot_at ?place))
                        (over all (is_thing_place ?thing ?place) )
                        (at start (free ?robot))
                )
                :effect (and
                        (at start (not (free ?robot)))
                        (at end (has ?thing ?robot))
                )
        )
	(:durative-action put_down
                :parameters (?robot - robot ?place - place ?thing - thing)
                :duration (= ?duration 5)
                :condition(and 
                        (at start (made_pd_decision ?robot))
                        (at start (robot_at ?place))
                        (over all (is_table_place ?place) )
                        (at start (has ?thing ?robot))
                        )
                :effect (and 
                        (at end (not(has ?thing ?robot)) )
                        (at end (on ?thing ?place))
                        (at end (free ?robot))
                        (at end (sated ?robot))
                )
        )
)
