#import "/templates/academic.typ": *
#show: academic.with(
  title: "Comparison Sorting Lower Bound",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 7, 11, 14–15
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Why comparison sorting cannot beat $Omega(n log n)$ in general
Your class notes build a *decision tree*: every comparison has (at most) two outcomes, and each root-to-leaf path represents a sequence of decisions.

For $n$ distinct items, all $n!$ permutations must be distinguishable. Thus a correct deterministic comparison sorter requires a decision tree with at least $n!$ leaves.

A binary tree of height $h$ has at most $2^h$ leaves. Therefore
$ 2^h >= n!, quad h >= log_2(n!) = Omega(n log n). $

The worst-case number of comparisons is at least $Omega(n log n)$, and the average-case lower bound is also $Omega(n log n)$ under a uniform random input permutation.

== What the bound does and does not say
- It applies to algorithms whose *only* way to learn ordering is by comparing keys.
- It does *not* rule out $O(n)$ counting sort, radix sort, or bucket sort under restricted key assumptions.
- Merge sort achieves $Theta(n log n)$, so it is asymptotically optimal within the comparison model.

== A small example
For $n=3$, there are $3!=6$ possible permutations, requiring at least $ceil(log_2 6)=3$ comparisons along some execution path.

*Exam phrasing:* Say “$Omega(n log n)$ comparisons in the comparison model,” not “every sorting algorithm takes $Omega(n log n)$.”
