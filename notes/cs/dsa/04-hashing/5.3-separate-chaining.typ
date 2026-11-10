#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.3 Separate Chaining",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 2–3, 6, 8
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Collision handling with buckets
Store a container at every hash-table position. If `21`, `31` and `41` all hash to index `1`, their records share bucket 1.

== Basic operations
- `insert(x)`: compute $i=h(x)$; check whether $x$ already exists if duplicates are disallowed, then add to bucket $i$.
- `contains(x)`: compute $i$; scan or query only bucket $i$.
- `remove(x)`: find and remove $x$ from bucket $i$.

== Expected time
Under simple uniform hashing, each bucket has expected length about $alpha=n/m$. Expected unsuccessful search and insert work is $Theta(1+alpha)$. If $alpha=O(1)$ via resizing, this becomes expected $O(1)$.

== Worst case
If all keys collide into one linked list, searching takes $Theta(n)$ time. This is why a low load factor alone does not replace a good hash function.

== Advantages
- Deletion is straightforward.
- Number of stored entries may exceed the number of buckets.
- Works with linked lists, dynamic arrays, or other bucket containers.

*Correction/qualification:* Expected operation costs assume a distribution model; a specific adversarial set of keys can behave much worse.
