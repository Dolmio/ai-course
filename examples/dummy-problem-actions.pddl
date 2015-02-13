(define (domain gripper-strips)
    (:requirements :typing)
    (:types
        room
        missionary 
        cannibal
        person
        boat
        location
        )

(:predicates
    (person-at ?loc - location ?per - person)
    (boat-at ?loc - location ?boat - boat)
    (on-boat ?per - person ?boat - boat) 
    (at-robby ?r - room)
)
(:action move
    :parameters (?from - room  ?to - room)
    :precondition (and (at-robby ?from))
    :effect (and (at-robby ?to) (not (at-robby ?from))))



(:action move-boat
    :parameters (?from - location ?to - location ?boat - boat)
    :precondition (and (boat-at ?from ?boat))
    :effect (and (boat-at ?to ?boat) (not (boat-at ?from ?boat)))

    )


(:action board-into-boat
    :parameters (?boat - boat ?person - person ?location - location)
    :precondition (and (person-at ?location ?person) 
                       (boat-at ?location ?boat))
    :effect (and (on-boat ?person ?boat)
                    (not (person-at ?location ?person))))
    
(:action leave-boat
    :parameters (?person - person ?boat - boat ?location - location)
    :precondition (and (on-boat ?person ?boat)
                        (boat-at ?location ?boat)
                        )
    :effect (and (person-at ?location ?person)
                    (not (on-boat ?person ?boat)))
    )

    )

