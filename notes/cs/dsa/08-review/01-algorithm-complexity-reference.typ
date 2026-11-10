#import "/templates/academic.typ": *
#show: academic.with(
  title: "Algorithm Runtime Reference",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1–4, consolidated
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Quick reference
This is a consolidated study aid *added* from the algorithms covered in the four scans. It is not a separate lecture section.

#table(
  columns: (2fr, 2fr, 2fr),
  inset: 6pt,
  stroke: .4pt + luma(180),
  [*Algorithm*], [*Typical / best case*], [*Worst case*],
  [Binary search], [$Theta(log n)$], [$Theta(log n)$],
  [Merge sort], [$Theta(n log n)$], [$Theta(n log n)$],
  [Quick sort], [$Theta(n log n)$ expected], [$Theta(n^2)$],
  [Counting sort], [$Theta(n+k)$], [$Theta(n+k)$],
  [Radix sort], [$Theta(d(n+b))$], [$Theta(d(n+b))$],
  [BST search], [$O(log n)$ if balanced], [$Theta(n)$],
  [AVL search], [$O(log n)$], [$O(log n)$],
  [Trie search], [$O(L)$], [$O(L)$],
  [Heap insert/extract], [$O(log n)$], [$O(log n)$],
  [Hash lookup], [$O(1)$ expected], [$O(n)$],
  [BFS / DFS], [$Theta(V+E)$], [$Theta(V+E)$],
  [Dijkstra (heap)], [$O((V+E)log V)$], [$O((V+E)log V)$],
  [Bellman–Ford], [$O(V E)$], [$O(V E)$],
  [Edmonds–Karp], [$O(V E^2)$], [$O(V E^2)$],
)

== When to use each
- Need sorted keys / ordered iteration? Prefer a balanced BST or ordered map.
- Need fast expected membership by key, order unimportant? Hash table.
- Need prefix lookup across strings? Trie.
- Need repeatedly choose smallest active priority? Min-heap.
- Need shortest path by edge count? BFS.
- Need weighted shortest paths? Dijkstra for nonnegative weights; Bellman–Ford for negative edges.
- Need maximum source-to-sink throughput? Maximum-flow algorithms.

*Assumptions:* Graph costs above use adjacency lists. Hash-table expected costs assume acceptable distribution. Sorting bounds specify relevant key conditions. Heap costs are worst-case per operation, not necessarily tight for every individual call.
