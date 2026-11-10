#import "/templates/academic.typ": *
#show: academic.with(
  title: "Graphs and Representations",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 8–10, 16–17; Part 4, pp. 1–2
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Basic graph vocabulary
A graph is $G=(V,E)$: vertices (nodes) connected by edges. The notes distinguish:
- *Undirected* edges, where connection can be traversed either way.
- *Directed* edges, where $(u,v)$ has a specified direction.
- *Weighted* graphs, where each edge has weight $w(u,v)$.

== Adjacency list
For each vertex, store its neighbors (and weights if needed):
```cpp
vector<vector<pair<int,int>>> adj(n);
adj[u].push_back({v, weight});
```
Undirected edge insertion adds both directions. Space: $Theta(V+E)$; enumerating all neighbors of $v$ takes $Theta(deg(v))$.

== Adjacency matrix
Store $A[u][v]$, e.g. a Boolean edge flag or edge weight. Space: $Theta(V^2)$. Looking up whether one edge exists is $Theta(1)$, but listing all neighbors of a vertex takes $Theta(V)$.

== Sparse vs dense
A sparse graph has relatively few edges, often $E=O(V)$. A dense simple graph can have $Theta(V^2)$ edges.

== Representation and algorithm costs
On adjacency lists, BFS/DFS take $Theta(V+E)$ time. With adjacency matrix scanning, they take $Theta(V^2)$ time. Do not quote complexity without remembering the representation assumption.

*Terminology:* $V$ is the set of vertices and $E$ is the set of edges; in expressions like $O(V+E)$, the letters denote their *counts*.
