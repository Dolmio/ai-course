(define (problem missionaries)
   (:domain toyproblem)
   (:objects m1 m2 m3 - missionary
             c1 c2 c3 - cannibal
             wrong-side right-side - place
             boat - boat)

             (:init
             (at m1 wrong-side)
             (at m2 wrong-side)
             (at m3 wrong-side)
             (at c1 wrong-side)
             (at c2 wrong-side)
             (at c3 wrong-side)
             (in-side boat wrong-side))

             (:goal
              (and
                (at m1 right-side)
                (at m2 right-side)
                (at m3 right-side)
                (at c1 right-side)
                (at c2 right-side)
                (at c3 right-side)
              )
             )
             )