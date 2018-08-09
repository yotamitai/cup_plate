(define (domain table_domain)
	(:requirements :strips :typing :equality :durative-actions :negative-preconditions)
        (:types 
                place robot thing 
        )       
	(:predicates 
                (robot_at ?p - place)
                (human_at ?p - place) 
                (is_place ?place - place) 
                (is_thing_place ?t - thing ?p - place)
                (has ?t - thing ?p - robot)
                (on ?t - thing ?p - place)
                (is_table_place ?p - place)
                (free ?p - robot)
	)
	(:durative-action move_to_object
		:parameters (?place - place ?oldplace - place ?robot - robot)
                :duration (= ?duration 2)
		:condition(and
		        ;   (over all (not(= ?place ?oldplace)))
		        ;   (at start (not(human_at ?place)))
		          (at start (robot_at ?oldplace))
                )
		:effect (and (at end (robot_at ?place))
		         (at start (not (robot_at ?oldplace))))
	)
)
