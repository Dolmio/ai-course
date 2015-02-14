(define (domain gripper-strips)
    (:requirements :typing :equality :conditional-effects)
    (:types
        room - room
        missionary cannibal - person
        boat - boat
        location - location
        num - num
        )

(:predicates
    (person-at ?loc - location ?per - person)
    (boat-at ?loc - location ?boat - boat)
    (on-boat ?per - person ?boat - boat) 
    (on-boat-0 ?n)
    (on-boat-1 ?n)
    (on-boat-2 ?n)
    (counts-in-location ?loc - location ?number-of-cannibals - int ?number-of-missionaries - int)
    (missionary ?m - person)
    (cannibal ?c - person)
    (can-board-missionary ?number-of-missionaries - int ?number-of-cannibals - int)
    (can-leave-boat-cannibal ?number-of-missionaries - int ?number-of-cannibals - int)
    (decrement ?a - int ?b - int)
    (increment ?a - int ?b - int)

)

(:action move-boat
    :parameters (?from - location ?to - location ?boat - boat ?on-boat-count - num)
    :precondition (and (boat-at ?from ?boat) (not (on-boat-0 ?on-boat-count)))
    :effect (and (boat-at ?to ?boat) (not (boat-at ?from ?boat)))

    )


(:action board-cannibal-into-boat
    :parameters (?boat - boat ?person - person ?location - location ?on-boat-count - num)
    :precondition (and (person-at ?location ?person) 
                       (boat-at ?location ?boat)
                       (not (on-boat-2 ?on-boat-count))
                       (cannibal ?person)
                       )
    :effect (and (on-boat ?person ?boat)
                 (not (person-at ?location ?person))
                  (when (on-boat-0 ?on-boat-count)
                      (and (on-boat-1 ?on-boat-count)
                           (not (on-boat-0 ?on-boat-count))))
                  (when (on-boat-1 ?on-boat-count)
                      (and (on-boat-2 ?on-boat-count)
                           (not (on-boat-1 ?on-boat-count))))
                
            ))

(:action board-missionary-into-boat
    :parameters (?boat - boat ?person - person ?location - location ?on-boat-count - num)
    :precondition (and (person-at ?location ?person) 
                       (boat-at ?location ?boat)
                       (not (on-boat-2 ?on-boat-count))
                       (missionary ?person)
                       )
    :effect (and (on-boat ?person ?boat)
                 (not (person-at ?location ?person))
                  (when (on-boat-0 ?on-boat-count)
                      (and (on-boat-1 ?on-boat-count)
                           (not (on-boat-0 ?on-boat-count))))
                  (when (on-boat-1 ?on-boat-count)
                      (and (on-boat-2 ?on-boat-count)
                           (not (on-boat-1 ?on-boat-count))))
                
            ))
    
(:action missionary-leave-boat
    :parameters (?person - person ?boat - boat ?location - location ?on-boat-count - num)
    :precondition (and (on-boat ?person ?boat)
                        (boat-at ?location ?boat)
                        (missionary ?person)
                        )
    :effect (and (person-at ?location ?person)
                 (not (on-boat ?person ?boat))
                 (when (on-boat-1 ?on-boat-count)
                    (and (on-boat-0 ?on-boat-count)
                         (not (on-boat-1 ?on-boat-count))))
                 (when (on-boat-2 ?on-boat-count)
                    (and (on-boat-1 ?on-boat-count)
                         (not (on-boat-2 ?on-boat-count))))))

(:action cannibal-leave-boat
    :parameters (?person - person ?boat - boat ?location - location ?on-boat-count - num)
    :precondition (and (on-boat ?person ?boat)
                        (boat-at ?location ?boat)
                        (cannibal ?person)
                        )
    :effect (and (person-at ?location ?person)
                 (not (on-boat ?person ?boat))
                 (when (on-boat-1 ?on-boat-count)
                    (and (on-boat-0 ?on-boat-count)
                         (not (on-boat-1 ?on-boat-count))))
                 (when (on-boat-2 ?on-boat-count)
                    (and (on-boat-1 ?on-boat-count)
                         (not (on-boat-2 ?on-boat-count)))))))

