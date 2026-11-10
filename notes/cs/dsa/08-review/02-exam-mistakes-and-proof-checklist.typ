#import "/templates/academic.typ": *
#show: academic.with(
  title: "Common Exam Mistakes and Proof Checklist",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1–4, consolidated with clarifying additions
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Exam checklist
Use these questions to verify a solution before submitting it.

== Runtime and asymptotics
- Is the problem asking for $O$, $Omega$, or a tight $Theta$ bound?
- Are loops sequential (add costs) or nested (multiply/sum costs)?
- Is the input size $n$, $V+E$, word length $L$, or key range $k$?
- Does the recurrence reflect the *actual* recursive calls and combine cost?
- Are the assumptions of the Master Theorem satisfied?

== Trees and heaps
- BST worst-case search/insert: $Theta(n)$ if the tree is a chain.
- AVL balance must hold at *every* node; rotations preserve BST order.
- Heap is not globally sorted, and it is not a BST.
- In a trie, a prefix can exist even if `isEnd` is false; `numEntries` counts terminal nodes in a subtree.

== Sorting
- Quick sort's worst case is quadratic with badly chosen pivots.
- The $Omega(n log n)$ lower bound applies to comparison sorting, not all sorting.
- LSD radix sort requires a stable digit sorter.

== Graphs
- BFS minimizes edge count in unweighted graphs; Dijkstra minimizes total nonnegative weight.
- Dijkstra cannot safely finalize nodes if negative edges are allowed.
- Bellman–Ford's negative-cycle test applies to *reachable* cycles.
- An undirected edge is represented in both adjacency lists, but only once logically.
- A shortest-path claim should include a valid path and its distance, or an invariant justifying optimality.

== Flow
- Every residual forward edge should be paired with its reverse residual edge.
- A min cut sums only the capacity of edges crossing from source side to sink side.
- Ford–Fulkerson's $O(E|f^*|)$ bound assumes integral capacities.

== Proof style
Write the invariant/claim, establish its base case, show why one iteration or recursive step preserves it, and conclude that the returned result has the required property.
