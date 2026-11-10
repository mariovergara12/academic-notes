#import "/templates/academic.typ": *
#show: academic.with(
  title: "Reconstructing Paths and Common Graph Bugs",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 12–15, 19–24
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Parent pointers
BFS, Dijkstra and Bellman–Ford can store `parent[v] = u` whenever they first discover a better route to `v`.

```cpp
vector<int> getPath(int s, int t,
                    const vector<int>& parent) {
    vector<int> path;
    for (int v = t; v != -1; v = parent[v]) {
        path.push_back(v);
        if (v == s) break;
    }
    if (path.empty() || path.back() != s) return {};
    reverse(path.begin(), path.end());
    return path;
}
```

== Correctness checklist
1. Initialize all distances to “infinity” except `dist[s]=0`.
2. Do not relax from unreachable vertices; guard against overflow.
3. Record predecessors when a *better* distance is found, not arbitrarily.
4. Reconstruct from target backward to source, then reverse.
5. Reject paths to unreachable targets.
6. If Bellman–Ford finds a reachable negative cycle affecting the target, a finite shortest path may not exist.

== Directed edges
If the graph is directed, do not automatically add a reverse edge. For an undirected graph, store both directions in an adjacency list.

== Weighted vs unweighted
BFS finds the minimum number of edges, which is *not* always minimum sum of weights. Use Dijkstra only for nonnegative weighted graphs, and Bellman–Ford when negative edges are possible.
