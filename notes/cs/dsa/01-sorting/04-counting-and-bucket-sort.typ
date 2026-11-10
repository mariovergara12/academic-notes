#import "/templates/academic.typ": *
#show: academic.with(
  title: "Counting Sort and Bucket Sort",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 11–13, 18–20
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Linear-time sorting outside the comparison model
These algorithms use restrictions on the keys to avoid repeatedly comparing arbitrary pairs.

== Counting sort
Assume $n$ integer keys in the range $0,1,...,k$.
1. Allocate counts $C[0..k]$ initialized to zero.
2. Count occurrences of each key.
3. Convert counts into cumulative counts if stable placement is needed.
4. Place each element into the output at its correct position.

Runtime $Theta(n+k)$ and auxiliary space $Theta(n+k)$ for the stable version; counting alone uses $Theta(k)$ extra space.

== Bucket sort
Your notes describe grouping values into buckets by numeric range. In the simplest integer-key case, bucket counts can be scanned to emit elements in sorted order.

For keys distributed uniformly over $[0,1)$, a more general bucket sort places each value into one of $n$ buckets and sorts each bucket. Under standard uniformity assumptions its expected runtime is $Theta(n)$; *worst case* can be $Theta(n^2)$ if many elements land in one bucket and insertion sort is used.

== Why range assumptions matter
If $k$ grows enormously compared with $n$, counting sort's $Theta(n+k)$ cost can be worse than comparison sorting. It is not automatically $Theta(n)$ without a bound on the key universe.

== Exam examples
Sorting scores in `[0,100]` with counts is an excellent fit. Sorting unrestricted real numbers is not automatically a counting-sort problem.
