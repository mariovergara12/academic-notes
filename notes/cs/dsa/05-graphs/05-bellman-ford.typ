#import "/templates/academic.typ": *
#show: academic.with(
  title: "Bellman–Ford and Negative Cycles",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 20–24; Part 4, p. 1
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Why Bellman–Ford?
Like Dijkstra, it solves single-source shortest paths, but it also handles *negative edge weights*. It detects reachable negative cycles that make finite shortest paths impossible.

#image("../diagrams/bellman-example.svg", width: 73%)

== Algorithm (edge-list C++)
```cpp
struct Edge { int u, v; long long w; };
const long long INF = LLONG_MAX / 4;
vector<long long> dist(n, INF);
vector<int> parent(n, -1);
dist[s] = 0;
for (int pass = 1; pass < n; ++pass) {
    bool changed = false;
    for (const auto& e : edges) {
        if (dist[e.u] == INF) continue;
        if (dist[e.u] + e.w < dist[e.v]) {
            dist[e.v] = dist[e.u] + e.w;
            parent[e.v] = e.u;
            changed = true;
        }
    }
    if (!changed) break;
}
// One additional pass checks for a reachable negative cycle.
for (const auto& e : edges) {
    if (dist[e.u] != INF && dist[e.u] + e.w < dist[e.v]) {
        // A negative cycle is reachable from s.
    }
}
```

== Why $V-1$ rounds?
A simple path on $V$ vertices has at most $V-1$ edges. After $k$ full relaxation rounds, distances account for paths using up to $k$ edges (interpretation independent of iteration order using previous-pass values; in-place relaxations can improve faster).

== Negative-cycle detection
If any *reachable* edge is still relaxable after the usual passes, there is a reachable negative cycle. If that cycle can reach another vertex, that vertex's shortest-path value is not finite.

== Runtime and memory
$O(V E)$ time for $V-1$ scans of all edges plus a final scan. $O(V)$ extra memory for the distance and predecessor arrays, excluding stored graph.

*Clarification:* An unreachable negative cycle must not trigger the reachable-source warning. Guard relaxations with `dist[u] != INF`.
