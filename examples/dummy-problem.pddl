(define (problem strips-gripper2)
    (:domain gripper-strips)
    (:objects rooma roomb)
    (:init 
            (room rooma)
            (room roomb)
            (at-robby rooma)
            )
(:goal (at-robby roomb)))