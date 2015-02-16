(define (domain missionaries)
    (:requirements :typing :conditional-effects :adl)
    (:types
        missionary cannibal - person
        boat - boat
        location - location
        more-missionaries-count -  more-missionaries-count
        )

(:predicates
    (person-at ?loc - location ?per - person)
    (boat-at ?loc - location ?boat - boat)
    (on-boat ?per - person ?boat - boat) 
    (on-boat-0)
    (on-boat-1)
    (on-boat-2)
    (missionary ?m - person)
    (cannibal ?c - person)
    (can-board-missionary ?c - more-missionaries-count)
    (can-leave-boat-cannibal ?c - more-missionaries-count)
    (decrement ?a - more-missionaries-count ?b - more-missionaries-count)
    (increment ?a - more-missionaries-count ?b - more-missionaries-count)
    (more-missionaries-in-location ?loc - location ?c - more-missionaries-count)

)

(:action move-boat
    :parameters (?from - location ?to - location ?boat - boat)
    :precondition (and (boat-at ?from ?boat) (not (on-boat-0)))
    :effect (and (boat-at ?to ?boat) (not (boat-at ?from ?boat)))

    )

(:action board-into-boat
    :parameters (?boat - boat ?person - person ?location - location ?more-missionaries-count - more-missionaries-count ?new-more-missionaries-count - more-missionaries-count)
    :precondition (and (person-at ?location ?person) 
                       (boat-at ?location ?boat)
                       (not (on-boat-2))
                       (more-missionaries-in-location ?location ?more-missionaries-count)
                       (or (and (missionary ?person)
                                (decrement ?new-more-missionaries-count ?more-missionaries-count)
                                (can-board-missionary ?more-missionaries-count))
                           (and (cannibal ?person)
                                (increment ?new-more-missionaries-count ?more-missionaries-count))))
    :effect (and (on-boat ?person ?boat)
                 (not (person-at ?location ?person))
                 (more-missionaries-in-location ?location ?new-more-missionaries-count)
                 (not (more-missionaries-in-location ?location ?more-missionaries-count))
                  (when (on-boat-0)
                      (and (on-boat-1)
                           (not (on-boat-0))))
                  (when (on-boat-1)
                      (and (on-boat-2)
                           (not (on-boat-1))))
                
            ))
    
(:action leave-boat
    :parameters (?person - person ?boat - boat ?location - location ?more-missionaries-count - more-missionaries-count ?new-more-missionaries-count - more-missionaries-count)
    :precondition (and (on-boat ?person ?boat)
                        (boat-at ?location ?boat)
                        (more-missionaries-in-location ?location ?more-missionaries-count)
                        (or 
                            (and (missionary ?person)
                                 (increment ?new-more-missionaries-count ?more-missionaries-count))
                            (and (cannibal ?person)
                                 (decrement ?new-more-missionaries-count ?more-missionaries-count)
                                 (can-leave-boat-cannibal ?more-missionaries-count))))

    :effect (and (person-at ?location ?person)
                 (not (on-boat ?person ?boat))
                 (more-missionaries-in-location ?location ?new-more-missionaries-count)
                 (not (more-missionaries-in-location ?location ?more-missionaries-count))
                 (when (on-boat-1)
                    (and (on-boat-0)
                         (not (on-boat-1))))
                 (when (on-boat-2)
                    (and (on-boat-1)
                         (not (on-boat-2))))))
)

