#import "/templates/academic.typ": *

#show: academic.with(
  title: "Recurrences and Recursion Trees",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 5, 15–17; Part 4, pp. 8, 14–16

= Analyze Recursive Algorithms

A recurrence expresses the running time of an algorithm on input size $n$ in terms of smaller inputs.

For merge sort, the recurrence is:

$
  T(n) = 2 T(n / 2) + c n,
  quad T(1) = Theta(1)
$

#image("../diagrams/recursion-tree.svg", width: 66%)

== Level-by-Level Method

At level $i$, merge sort has $2^i$ subproblems, each of size $n / 2^i$.

The nonrecursive work at that level is:

$
  2^i dot c (n / 2^i) = c n
$

The recursion tree has approximately $log_2 n$ levels, plus the leaves.

Each level performs $Theta(n)$ work.

Therefore, the total running time is:

$
  T(n) = Theta(n log n)
$

== Another Pattern

Consider:

$
  T(n) = T(n / 2) + Theta(1)
$

There is one recursive subproblem per level.

The tree has $Theta(log n)$ levels, with constant work at each level.

Therefore:

$
  T(n) = Theta(log n)
$

Now consider:

$
  T(n) = 4 T(n / 2) + Theta(n)
$

At level $i$, the work is:

$
  4^i dot c (n / 2^i) = c n 2^i
$

The last level dominates the total work.

The number of leaves is:

$
  4^(log_2 n) = n^2
$

Therefore:

$
  T(n) = Theta(n^2)
$

== General Setup

A common divide-and-conquer recurrence has the form:

$
  T(n) = a T(n / b) + f(n)
$

where $a >= 1$ and $b > 1$.

The recursion tree has approximately $log_b n$ levels and $a^i$ nodes at level $i$.

The critical comparison is between:

$
  f(n) quad "and" quad n^(log_b a)
$

The Master Theorem formalizes the different cases.

== Important Reminder

The recurrence:

$
  T(n) = 2 T(n / 2) + O(n)
$

only establishes an upper bound unless a matching lower bound is known.

When the nonrecursive work has a matching upper and lower bound, write:

$
  T(n) = 2 T(n / 2) + Theta(n)
$

For merge sort, this gives:

$
  T(n) = Theta(n log n)
$
