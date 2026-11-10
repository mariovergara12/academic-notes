#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.4 Open Addressing, Probing and Tombstones",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 3–5
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Store keys directly in the table
In open addressing every key occupies a table slot. On collision, visit other slots in a *probe sequence*. The load factor satisfies $0 <= alpha <= 1$ for a table that stores at most one live key per slot.

== Linear probing
$ h_i(x)=(h(x)+i) mod m, quad i=0,1,2,... $
Try the next slot until an empty one appears. Your notes point out *primary clustering*: long consecutive runs make future probes slower.

== Quadratic probing
$ h_i(x)=(h(x)+c_1 i+c_2 i^2) mod m. $
A common special case uses square offsets $0,1,4,9,...$. This reduces primary clustering but does *not* automatically visit every slot. Correct parameter choice, table size and load limit matter.

== Double hashing
$ h_i(x)=(h_1(x)+i h_2(x)) mod m. $
Choose $h_2(x)$ relatively prime to $m$ so the probe can cover the entire table. Distinct steps help reduce clustering.

== Deletion: three slot states
- `EMPTY` — never occupied; an unsuccessful lookup may stop here.
- `OCCUPIED` — holds a live key.
- `DELETED` / tombstone — previously occupied; a search must *continue past it*.

If you mark a removed position `EMPTY` instead of using a tombstone, you may prematurely terminate a later search for a key farther along the same probe sequence.

== Costs
Expected $O(1)$ operations are feasible at suitably low load factors. Worst-case search/insert costs are $O(m)$ probes.
