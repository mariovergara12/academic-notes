#import "/templates/academic.typ": *
#show: academic.with(
  title: "Merge k Sorted Lists with a Heap",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, p. 7; Part 2, p. 22
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Problem
Input: $k$ individually sorted lists holding $n$ total elements. Output: all $n$ elements in sorted order.

== Heap approach
Insert the first element from each nonempty list into a min-heap, together with its list index. Repeat:
1. Extract the smallest current head.
2. Append its key to output.
3. Advance that list and insert its next element (if any).

Because the heap never contains more than $k$ items, each extraction/insertion is $O(log k)$. Total running time is
$ Theta(n log k) $
assuming every item is output once. Auxiliary heap memory is $O(k)$, not counting output.

== Why it matters
This combines your class's heap examples with the k-way merge exercise in Part 3. A naive scan of all $k$ list heads at every step would take $O(n k)$ time.
