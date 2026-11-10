#import "/templates/academic.typ": *
#show: academic.with(
  title: "Bipartite Matching as Network Flow",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 4, pp. 6–7
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Bipartite matching
A bipartite graph has vertex sets $L$ and $R$, with edges only between the sets. A matching chooses edges so that no vertex is used more than once.

#image("../diagrams/bipartite-matching.svg", width: 60%)

== Reduction to maximum flow
To find a maximum matching:
1. Add a source $s$ and connect it to every $u in L$ with capacity 1.
2. Direct every original bipartite edge from $L$ to $R$, with capacity 1.
3. Connect each $v in R$ to sink $t$ with capacity 1.
4. Run a maximum-flow algorithm.

Because capacities are integral, a maximum integral flow corresponds to a matching. Each unit of flow along an $L -> R$ edge selects one matching pair.

== Why this is useful
An algorithm for network flow can solve assignment and pairing problems without inventing a wholly new algorithm. Your class notes also allude to reductions between flow, matching, and tile problems; those arrows are motivational, not a proof that all versions of those problems are equivalent.

== Exam reminder
The matching cardinality equals the maximum flow value in the constructed network. Capacity 1 on both source-side and sink-side edges is what prevents assigning one vertex to multiple partners.
