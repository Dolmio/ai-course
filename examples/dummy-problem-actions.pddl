(define (domain missionaries)
    (:requirements :typing :conditional-effects :adl)
    (:types
        missionary cannibal - person
        boat - boat
        location - location
        )

(:predicates
    (person-at ?loc - location ?per - person)
    (boat-at ?loc - location ?boat - boat)
    (on-boat ?per - person ?boat - boat) 
    (on-boat-0)
    (on-boat-1)
    (on-boat-2)
    (counts-in-location ?loc - location ?number-of-cannibals - int ?number-of-missionaries - int)
    (missionary ?m - person)
    (cannibal ?c - person)
    (can-board-missionary ?number-of-missionaries - int ?number-of-cannibals - int)
    (can-leave-boat-cannibal ?number-of-missionaries - int ?number-of-cannibals - int)
    (decrement ?a - int ?b - int)
    (increment ?a - int ?b - int)

)

(:action move-boat
    :parameters (?from - location ?to - location ?boat - boat)
    :precondition (and (boat-at ?from ?boat) (not (on-boat-0)))
    :effect (and (boat-at ?to ?boat) (not (boat-at ?from ?boat)))

    )

(:action board-into-boat
    :parameters (?boat - boat ?person - person ?location - location ?nc - int ?nm - int ?new-number-of-missionaries - int ?new-number-of-cannibals - int)
    :precondition (and (person-at ?location ?person) 
                       (boat-at ?location ?boat)
                       (not (on-boat-2))
                       (counts-in-location ?location ?nc ?nm)
                       (or (and (missionary ?person)
                                (decrement ?new-number-of-missionaries ?nm)
                                (can-board-missionary ?nm ?nc))
                           (and (cannibal ?person)
                                (decrement ?new-number-of-cannibals ?nc))))
    :effect (and (on-boat ?person ?boat)
                 (not (person-at ?location ?person))

                 (when (missionary ?person)
                    (and (counts-in-location ?location ?nc ?new-number-of-missionaries)
                         (not (counts-in-location ?location ?nc ?nm))))
                 (when (cannibal ?person)
                    (and (counts-in-location ?location ?new-number-of-cannibals ?nm)
                         (not (counts-in-location ?location ?nc ?nm))))
                  (when (on-boat-0)
                      (and (on-boat-1)
                           (not (on-boat-0))))
                  (when (on-boat-1)
                      (and (on-boat-2)
                           (not (on-boat-1))))
                
            ))
    
(:action leave-boat
    :parameters (?person - person ?boat - boat ?location - location ?nc - int ?nm - int ?new-number-of-missionaries - int ?new-number-of-cannibals - int)
    :precondition (and (on-boat ?person ?boat)
                        (boat-at ?location ?boat)
                        (counts-in-location ?location ?nc ?nm)
                        (or 
                            (and (missionary ?person)
                                 (increment ?new-number-of-missionaries ?nm))
                            (and (cannibal ?person)
                                 (increment ?new-number-of-cannibals ?nc)
                                 (can-leave-boat-cannibal ?nm ?nc))))

    :effect (and (person-at ?location ?person)
                 (not (on-boat ?person ?boat))
                 (when (missionary ?person)
                    (and (counts-in-location ?location ?nc ?new-number-of-missionaries)
                         (not (counts-in-location ?location ?nc ?nm))))
                 (when (cannibal ?person)
                    (and (counts-in-location ?location ?new-number-of-cannibals ?nm)
                         (not (counts-in-location ?location ?nc ?nm))))
                 (when (on-boat-1)
                    (and (on-boat-0)
                         (not (on-boat-1))))
                 (when (on-boat-2)
                    (and (on-boat-1)
                         (not (on-boat-2))))))
)

