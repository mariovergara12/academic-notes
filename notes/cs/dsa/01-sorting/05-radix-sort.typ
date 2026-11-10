#import "/templates/academic.typ": *
#show: academic.with(
  title: "Radix Sort",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 12–13, 19–20
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Digit-by-digit sorting
Your reading notes sort three-digit integers in successive passes: ones, then tens, then hundreds. This is *least-significant-digit (LSD) radix sort*.

Example inputs: `064, 008, 216, 512, 027, 729, 000, 343, 125`.

== Algorithm
1. Sort by the rightmost digit using a *stable* subroutine.
2. Sort by the next digit, preserving the order of earlier digits where ties occur.
3. Continue until the most significant digit has been processed.

== Why stability matters
After pass $j$, items are ordered by their last $j$ digits. A stable sort on digit $j+1$ keeps the established order among ties, preserving the invariant.

== Runtime
For $d$ digits and base $b$, with counting sort per digit:
$ T(n)=Theta(d(n+b)). $
Space is typically $Theta(n+b)$. For a fixed number of bounded-base digits, this is linear in $n$.

== Radix vs. bucket/counting
- *Counting sort:* one whole integer key from a small universe.
- *Radix sort:* many stable digit passes.
- *Bucket sort:* partition keys into value ranges, then process each bucket.

*Class-note warning:* A non-stable sub-sort can break LSD radix sort.
