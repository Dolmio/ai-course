(define (problem missionaries-and-cannibals)
    (:domain missionaries)
    (:objects
              m1 m2 m3 - person
              c1 c2 c3 - person
              right-bank wrong-bank - location
              b1 - boat
              a0 a1 a2 a3 - more-missionaries-count
                )
    (:init 
            (person-at wrong-bank m1)
            (person-at wrong-bank m2)
            (person-at wrong-bank m3)
            (person-at wrong-bank c1)
            (person-at wrong-bank c2)
            (person-at wrong-bank c3)
            (boat-at wrong-bank b1)
            (on-boat-0)

            (missionary m1)
            (missionary m2)
             (missionary m3)
            
            (cannibal c1)
            (cannibal c2)
            (cannibal c3)
            
            (can-board-missionary a1)
            (can-board-missionary a2)
            (can-board-missionary a3)

            (can-leave-boat-cannibal a1)
            (can-leave-boat-cannibal a2)
            (can-leave-boat-cannibal a3)

            (more-missionaries-in-location wrong-bank a0)
            (more-missionaries-in-location right-bank a0)

            (increment a1 a0)
            (increment a2 a1)
            (increment a3 a2)

            (decrement a0 a1)
            (decrement a1 a2)
            (decrement a2 a3)
            )
(:goal (and (person-at right-bank m1)
            (person-at right-bank m2)
            (person-at right-bank m3)
           
            (person-at right-bank c1)
            (person-at right-bank c2)
            (person-at right-bank c3)


            )))