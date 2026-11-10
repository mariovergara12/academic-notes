#import "/templates/academic.typ": *
#show: academic.with(
  title: "Shortest-Path Algorithm Selection",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 10–13, 16, 19–24; Part 4, p. 1
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Choose based on edge weights
Your notebook compares BFS, Dijkstra and Bellman–Ford. The crucial question is whether edges are unweighted, nonnegative or can be negative.

== Decision guide
- *BFS:* unit-cost/unweighted edges; $Theta(V+E)$ with adjacency lists.
- *Dijkstra:* nonnegative edge weights; with a binary min-heap, $O((V+E)log V)$ (or $O(E log V+V log V)$).
- *Bellman–Ford:* permits negative edge weights; $O(V E)$; can detect negative cycles reachable from the source.

== Distance semantics
$"dist"[v]$ is the length of the best path discovered from source $s$ to vertex $v$. An edge $(u,v)$ with weight $w$ can be *relaxed* when
"$"dist"[u]+w<"dist"[v].$
Then assign $"dist"[v]="dist"[u]+w$ and optionally set $"parent"[v]=u$.

== Core differences
- BFS discovers in nondecreasing number of edges using a queue.
- Dijkstra repeatedly settles the minimum tentative-distance vertex using a priority queue.
- Bellman–Ford systematically relaxes edges up to $|V|-1$ times, allowing improvements to travel across the graph.

== Why negative cycles matter
If a *reachable* negative-weight cycle lies on a route to a target, there is no finite shortest-path distance to that target: walking around the cycle repeatedly makes the route cheaper without bound.

*Exam keyword:* Dijkstra's “settled is final” proof depends on nonnegative edge weights. Negative edges invalidate that proof.
