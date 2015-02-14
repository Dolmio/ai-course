(define (problem strips-gripper2)
    (:domain gripper-strips)
    (:objects rooma roomb - room
              m1 m2 m3 - (either missionary person)
              c1 c2 c3 - (either cannibal person)
              right-bank wrong-bank - location
              b1 - boat
              n - num
                )
    (:init 
            (at-robby rooma)
            (person-at wrong-bank m1)
            (person-at wrong-bank m2)
            (person-at wrong-bank m3)
            (person-at wrong-bank c1)
            (person-at wrong-bank c2)
            (person-at wrong-bank c3)
            (boat-at wrong-bank b1)
            (on-boat-0 n)
            )
(:goal (and (person-at right-bank m1)
            (person-at right-bank m2)
            (person-at right-bank m3)
            (person-at right-bank c1)
            (person-at right-bank c2)
            (person-at right-bank c3)


            )))