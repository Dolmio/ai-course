(ns assignments.core)

(defn parse-row [row]
  (map #(if (= \0 %) :floor :wall) row)
  )

(def tiles
  (->> (slurp "maze.txt")
       (clojure.string/split-lines)
       (map parse-row)))

(def floors
  (set (map #(dissoc % :type) (filter #(= :floor (:type %))
          (mapcat identity
                  (map-indexed (fn [y row]
                                 (map-indexed (fn [x cur]
                                                {:type cur :x x :y y}
                                                ) row)
                                 ) tiles))))) )

(def rows (count tiles))
(def columns (count (first tiles)))
(def goal-node {:x 0 :y 0})

(defn distance-to-goal [{:keys [x y]}]
  (Math/sqrt
    (double (+ (Math/pow (- (:y goal-node) y) 2) (Math/pow (- (:x goal-node) x) 2)))))

(defn cost [node]
  (+ (count (:route node)) (distance-to-goal (:location node))))

(defn get-neighbours [from-location]
  (set (filter identity
               [(if (not= 0 (:y from-location))
                  (update-in from-location [:y] dec)
                  )
                (if (not= (dec rows) (:y from-location))
                  (update-in from-location [:y] inc)
                  )
                (if (not= 0 (:x from-location))
                  (update-in from-location [:x] dec)
                  )
                (if (not= (dec columns) (:x from-location))
                  (update-in from-location [:x] inc)
                )]
               )))

(defn possible-locations [from-location]
  (let [neighbours (get-neighbours from-location)]
    (clojure.set/intersection neighbours floors)))

(defn node-to-expand [potential-nodes]
  (->> potential-nodes
       (map #(hash-map :node % :cost (cost %)))
       (apply min-key :cost)
       (:node)))

(defn new-node [location parent-node]
  {:location location :route (conj (:route parent-node) (:location parent-node))})

(def expand-count (atom 0))

(defn expand [expanded-node potential-nodes-to-expand]
  (if (= goal-node (:location expanded-node))
    (do (swap! expand-count inc)
        (:route expanded-node))

     (let [
           node-to-expand (node-to-expand potential-nodes-to-expand)
           new-leaves (map #(new-node % expanded-node) (possible-locations (:location expanded-node)))
           ]
       (swap! expand-count inc)
       (recur node-to-expand (clojure.set/difference (set (concat potential-nodes-to-expand new-leaves)) #{expanded-node})))))



(defn run []
     (let [start-position {:x 11 :y 11}]
       (expand {:location start-position :route []} (map #(hash-map :location % :route [start-position])(possible-locations start-position )))))










