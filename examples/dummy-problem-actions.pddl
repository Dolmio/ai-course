(define (domain gripper-strips)
    (:requirements :typing :equality :conditional-effects)
    (:types
        room
        missionary 
        cannibal
        person
        boat
        location
        num
        )

(:predicates
    (person-at ?loc - location ?per - person)
    (boat-at ?loc - location ?boat - boat)
    (on-boat ?per - person ?boat - boat) 
    (at-robby ?r - room)
    (on-boat-0 ?n)
    (on-boat-1 ?n)
    (on-boat-2 ?n)

)
(:action move
    :parameters (?from - room  ?to - room)
    :precondition (and (at-robby ?from))
    :effect (and (at-robby ?to) (not (at-robby ?from))))



(:action move-boat
    :parameters (?from - location ?to - location ?boat - boat ?on-boat-count - num)
    :precondition (and (boat-at ?from ?boat) (not (on-boat-0 ?on-boat-count)))
    :effect (and (boat-at ?to ?boat) (not (boat-at ?from ?boat)))

    )


(:action board-into-boat
    :parameters (?boat - boat ?person - person ?location - location ?on-boat-count - num)
    :precondition (and (person-at ?location ?person) 
                       (boat-at ?location ?boat)
                       (not (on-boat-2 num))
                       )
    :effect (and (on-boat ?person ?boat)
                 (not (person-at ?location ?person))
                
               
                    ))
    
(:action leave-boat
    :parameters (?person - person ?boat - boat ?location - location)
    :precondition (and (on-boat ?person ?boat)
                        (boat-at ?location ?boat)
                        )
    :effect (and (person-at ?location ?person)
                    (not (on-boat ?person ?boat)))
    )

    )

