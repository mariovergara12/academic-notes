#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.1 Hashing: General Idea",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 1, 6, 8
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Purpose
A hash table uses a hash function $h("key")$ to decide where a key belongs in an array of buckets or slots. Unlike a BST, a basic hash table does *not* preserve keys in sorted order.

Your class example uses $h(x)=x mod 10$: key `42` maps to slot `2`.

== Hash table goals
- Expected $O(1)$ insert, search, and remove under appropriate assumptions.
- Distribute keys evenly to avoid excessive collisions.
- Keep the load factor controlled.

== Collisions
A collision occurs when different keys map to the same location:
$ x != y quad "but" quad h(x)=h(y). $
Even a good hash function cannot eliminate collisions when the number of possible keys exceeds the number of table positions.

== Load factor
For $n$ stored elements and $m$ buckets, define
$ alpha=n/m. $
The meaning of a “full” table differs between separate chaining (multiple records may share one bucket) and open addressing (one record per slot).

== Two main strategies
- *Separate chaining*: each slot points to a bucket list or another container.
- *Open addressing*: keep every key inside the table array; probe for another slot after collision.

*Exam detail:* “Expected $O(1)$” depends on a good hash distribution and sufficient capacity. Hashing never guarantees constant-time operations on every input.
