(define
   (domain toyproblem)
   (:types missionary cannibal - person
     place - place
     boat - boat)

     (:predicates
     (at ?per - person ?loc - place)
     (in ?per - person ?veh - boat)
     (in-side ?veh - boat ?place - place))

     (:action move
     :parameters (?per - person ?from - place)
     :effect (and (not (at ?per ?from)) (at ?per right-side)))

     )