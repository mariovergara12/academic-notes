#import "/templates/academic.typ": *
#show: academic.with(
  title: "9.4 Maximum Flow, Residual Graphs and Cuts",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 4, pp. 2–4, 6–7
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Maximum-flow problem
In a directed capacitated network with source $s$ and sink $t$, maximize total flow leaving $s$ and reaching $t$.

#image("../diagrams/flow-example.svg", width: 77%)

== Feasible-flow conditions
Every edge $(u,v)$ has capacity $c(u,v)$ and flow $f(u,v)$ satisfying
$ 0 <= f(u,v) <= c(u,v). $
For every vertex except $s,t$, *flow conservation* requires total incoming flow to equal total outgoing flow.

== Residual network
For a forward edge with current flow $f$ and capacity $c$, remaining forward residual capacity is $c-f$. The reverse residual edge has capacity $f$, allowing previously chosen flow to be canceled or rerouted.

== Augmenting paths
An augmenting path runs from $s$ to $t$ using only positive residual-capacity edges. Its bottleneck is the minimum residual capacity along the path:
$ Delta=min_((u,v) "on path") c_f(u,v). $
Increase the flow along the path by $Delta$ (and update forward and reverse residual capacities).

== Ford–Fulkerson method
Repeat until no augmenting path remains. For *integer capacities*, each augmentation increases flow value by at least 1, giving the bound $O(E |f^*|)$ for DFS-based path searches, where $|f^*|$ is the maximum-flow value. This is pseudo-polynomial, not polynomial in the bit length of capacity values.

== Edmonds–Karp
Choose each augmenting path using BFS in the residual graph. It has worst-case time $O(V E^2)$, independent of numeric capacity magnitudes.

== Max-flow min-cut theorem
A cut partitions vertices into $S$ and $T$ with $s in S$ and $t in T$. Its capacity sums capacities on *directed edges from $S$ to $T$*. The maximum feasible flow value equals the minimum cut capacity.
