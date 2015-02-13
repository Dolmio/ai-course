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
    (at-robby ?r - room)
)
(:action move
    :parameters (?from - room  ?to - room)
    :precondition (and (at-robby ?from))
    :effect (and (at-robby ?to) (not (at-robby ?from))))


(:action move-person
    :parameters (?from - location ?to - location ?person - person)
    :precondition (and (person-at ?from ?person))
    :effect (and (person-at ?to ?person) (not (person-at ?from ?person)))

    )

)

