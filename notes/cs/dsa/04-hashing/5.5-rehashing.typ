#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.5 Rehashing and Load Factor",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, p. 5
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Why resize a hash table?
As entries accumulate, collisions and long probe sequences become more frequent. Rehashing allocates a larger table and reinserts all live elements using the new capacity.

== Steps
1. Choose a new table size, commonly a constant factor larger.
2. Create an empty new table.
3. Recompute each live key's *bucket index under the new size*.
4. Insert the entries into the new table.

Rehashing one table with $n$ entries costs $Theta(n)$ expected time with standard constant-time hash assumptions, but it happens occasionally.

== Amortized analysis
If table capacity doubles when full, each entry is moved only $O(log n)$ times over growth events, and the total work across $n$ inserts is $O(n)$ under the usual assumptions. Thus insertion has $O(1)$ *amortized* overhead from resizing.

*Exam distinction:* Amortized $O(1)$ does not mean that every insertion takes $O(1)$ time. A resize-triggering insertion can take $Theta(n)$.
