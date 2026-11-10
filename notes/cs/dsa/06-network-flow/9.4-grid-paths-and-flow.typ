#import "/templates/academic.typ": *
#show: academic.with(
  title: "Grid and Path Models Related to Flow",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 4, pp. 5–7
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Turning a grid into a graph
Sketch a grid of positive numbers with a “flattest path” objective, together with a layered graph. The conversion itself is useful:
- Create one vertex for each grid position or boundary state.
- Connect allowed moves by directed edges.
- Give an edge a cost representing the selected objective, e.g. local difference or step cost.
- Choose a graph algorithm appropriate to the objective.

== Distinguish objectives
- *Minimum total cost path:* sum edge weights, then use a shortest-path algorithm.
- *Minimize the maximum step cost (bottleneck path):* minimize $max_(e "on path") w(e)$, which differs from minimum sum.
- *Maximum flow:* route divisible units through capacities, possibly along many paths simultaneously.

The sketches do not fully specify the cost model, so I am keeping this as an algorithm-modeling note rather than claiming a definite solved recurrence for the pictured grid.

== Example: bottleneck shortest path idea
Replace ordinary relaxation with
$"candidate"=max("dist"[u], w(u,v)).$
Update if `candidate < dist[v]`. With nonnegative edge costs, a Dijkstra-like min-heap algorithm can minimize the largest edge weight on a source-target route.

*Important:* A graph reduction is only correct once you prove that paths/flows in the new graph correspond to valid solutions of the original task and preserve its objective.
