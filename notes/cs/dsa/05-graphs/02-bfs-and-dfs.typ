#import "/templates/academic.typ": *
#show: academic.with(
  title: "Breadth-First and Depth-First Search",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 10, 14–17; Part 3, pp. 19, 23
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= BFS: explore by distance layers
BFS starts from source $s$, uses a FIFO queue, and visits reachable vertices in order of increasing number of edges from $s$.

#image("../diagrams/bfs-example.svg", width: 78%)

```cpp
vector<int> dist(n, -1), parent(n, -1);
queue<int> q;
dist[s] = 0;
q.push(s);
while (!q.empty()) {
    int u = q.front(); q.pop();
    for (int v : adj[u]) {
        if (dist[v] != -1) continue;
        dist[v] = dist[u] + 1;
        parent[v] = u;
        q.push(v);
    }
}
```

BFS gives *shortest paths by edge count* in an unweighted graph. With all edges weight 1, this is also minimum total weight.

== DFS: explore one branch deeply
Use recursion or an explicit stack. DFS is useful for connected components, reachability, cycle detection, topological sorting in DAGs, and more.
```cpp
void dfs(int u, const vector<vector<int>>& adj,
         vector<bool>& seen) {
    seen[u] = true;
    for (int v : adj[u])
        if (!seen[v]) dfs(v, adj, seen);
}
```

== Costs
With adjacency lists, BFS and DFS are both $Theta(V+E)$ over a full traversal. BFS queue memory and DFS stack/recursion can each be $O(V)$.

*Exam traps:* DFS does not generally find shortest paths. Always mark a vertex when enqueuing it in BFS to prevent duplicate enqueues.
