(define (problem strips-gripper2)
    (:domain gripper-strips)
    (:objects rooma roomb - room
              m1 - (either missionary person)
              right-bank wrong-bank - location
                )
    (:init 
            (at-robby rooma)
            (person-at wrong-bank m1)
            )
(:goal (person-at right-bank m1)))