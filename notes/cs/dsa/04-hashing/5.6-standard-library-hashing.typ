#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.6 Hash Tables in C++",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, p. 6
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= C++ containers
The notes identify `std::unordered_set` and `std::unordered_map` as standard hash-based collections.

```cpp
#include <unordered_set>
#include <unordered_map>
using namespace std;

unordered_set<int> seen;
seen.insert(42);
bool has42 = seen.count(42) != 0;
seen.erase(42);

unordered_map<string, int> frequency;
frequency["cat"]++;
```

- `unordered_set<T>` stores unique keys.
- `unordered_map<K,V>` stores key-value pairs.
- Typical average insert/find/erase time: $O(1)$.
- Worst case: $O(n)$ for a single lookup/insert if many collisions arise.

== Contrast with ordered structures
`std::set` and `std::map` maintain sorted key order (typically balanced trees), with $O(log n)$ operations. `unordered_*` does not promise iteration in key order.

== Practical warning
If a custom key is used, supply a consistent hash and equality function: equal keys *must* have equal hash values.
