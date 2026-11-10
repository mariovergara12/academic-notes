#import "/templates/academic.typ": *
#show: academic.with(
  title: "Closest Pair of Points",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 4, pp. 11–12
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Problem
Given $n$ points in the plane, find two points minimizing Euclidean distance
$ d(p,q)=sqrt((p_x-q_x)^2+(p_y-q_y)^2). $

== Brute force
Check every pair: $binom(n, 2)=n(n-1)/2=Theta(n^2)$.

== Divide-and-conquer idea
1. Sort points by $x$-coordinate.
2. Split into left and right halves.
3. Recursively find the closest pair in each half, with best distance $delta$.
4. Any cross-boundary better pair must lie within distance $delta$ of the middle dividing line; examine the *strip*.

== Why checking the strip can be linear
Maintain points also sorted by $y$-coordinate. Geometric packing arguments show that each point needs comparison with only a constant number of subsequent points in strip $y$-order (often expressed as 7).

Then the combine step is $Theta(n)$ and
$ T(n)=2T(n/2)+Theta(n)=Theta(n log n). $

== Important implementation subtlety
The $Theta(n log n)$ result depends on maintaining/repartitioning the $y$-sorted order efficiently at every recursive step. Sorting the strip afresh at each level can instead yield an $O(n(log n)^2)$ implementation.

*Exam insight:* Merely dividing the point set in half is not enough: the difficult step is proving the cross-boundary strip can be processed efficiently.
