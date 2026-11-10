#import "/templates/academic.typ": *
#show: academic.with(
  title: "Dijkstra’s Algorithm (Lazy Min-Heap)",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 11–13, 16, 18–19, 23–24
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Problem
Find single-source shortest paths in a directed or undirected graph with *all edge weights nonnegative*.

#image("../diagrams/dijkstra-example.svg", width: 78%)

In this example, the path $s -> a -> b -> t$ has total cost $2+1+2=5$, better than going through $a$ directly to $t$ (cost $9$).

== Lazy priority-queue implementation (C++)
```cpp
using P = pair<long long,int>; // (distance, vertex)
const long long INF = LLONG_MAX / 4;
vector<long long> dist(n, INF);
vector<int> parent(n, -1);
priority_queue<P, vector<P>, greater<P>> pq;

dist[s] = 0;
pq.push({0, s});
while (!pq.empty()) {
    auto [d, u] = pq.top(); pq.pop();
    if (d != dist[u]) continue; // stale queue entry
    for (auto [v, w] : adj[u]) {
        if (dist[u] + w < dist[v]) {
            dist[v] = dist[u] + w;
            parent[v] = u;
            pq.push({dist[v], v});
        }
    }
}
```

== Why the stale-entry check works
A vertex might be inserted multiple times after improvements. Old queue entries become obsolete when their saved distance differs from `dist[u]`. Skipping them avoids unnecessary work without requiring decrease-key.

== Runtime
With a binary heap and adjacency lists: $O((V+E)log(V+E))$, commonly simplified to $O((V+E)log V)$ for simple graphs. For connected simple graphs this is often written $O(E log V)$.

== Negative-weight counterexample
#image("../diagrams/negative-edge-counterexample.svg", width: 68%)

Suppose $S -> A$ costs $2$, $S -> B$ costs $5$, and $B -> A$ costs $-4$. A standard version of Dijkstra that *finalizes* $A$ first at cost $2$ misses the shorter $S -> B -> A$ path of cost $1$. This demonstrates why the nonnegative assumption matters. Some lazy algorithms may accidentally recover on particular graphs if reprocessing is allowed; that does not restore Dijkstra's general guarantee.

*Exam reminder:* Be explicit about which Dijkstra version you mean: finalized/visited versus lazy stale-entry implementation.
