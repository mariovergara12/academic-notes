#import "/templates/academic.typ": *

#show: academic.with(
  title: "Divide and Conquer — Part II",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// References:
// Weiss, Data Structures and Algorithm Analysis in C++, §10.2
// CLRS, Introduction to Algorithms, §§4.2, 4.5, 9.3
// Ming-Yang Kao, Multiple-Size Divide-and-Conquer Recurrences (2001)

= 1. Divide and Conquer — Review

#definition[
  *Divide and conquer* is an algorithm design technique
  that divides a problem into smaller subproblems,
  solves them recursively, and combines their results.
]

The three main steps are:

+ *Divide:* Break the original problem into smaller subproblems.
+ *Conquer:* Solve each subproblem recursively.
+ *Combine:* Construct the final solution.

For equally sized subproblems, the general recurrence is:

$
  T(n) = a T(n/b) + f(n)
$

where:

- $a$: number of recursive subproblems.
- $b$: factor by which the input size decreases.
- $f(n)$: nonrecursive work (dividing and combining).

*Central insight:* Reducing the number or size of recursive calls
can greatly improve an algorithm's asymptotic runtime.

== Review: Master Theorem

Let

$
  T(n) = a T(n/b) + f(n)
$

and define

$
  d = log_b a
$

Compare $f(n)$ against $n^d$.

#theorem[
  *Case 1:* If $f(n) = O(n^(d - epsilon))$ for some
  constant $epsilon > 0$, then

  $
    T(n) = Theta(n^d)
  $

  *Case 2:* If $f(n) = Theta(n^d)$, then

  $
    T(n) = Theta(n^d log n)
  $

  *Case 3:* If $f(n) = Omega(n^(d + epsilon))$
  and the regularity condition holds, then

  $
    T(n) = Theta(f(n))
  $
]

For Case 3, the regularity condition is

$
  a f(n/b) <= c f(n)
$

for some constant $c < 1$ and all sufficiently large $n$.

= 2. Strassen's Matrix Multiplication

== 2.1 The Problem

Given two $n times n$ matrices $A$ and $B$, compute

$
  C = A B
$

Traditional matrix multiplication requires

$
  T(n) = Theta(n^3)
$

Strassen's algorithm reduces the number of recursive
multiplications, improving the asymptotic runtime.

== 2.2 Divide the Matrices

Partition each matrix into four equal-sized submatrices:

$
  A = mat(
    A_(11), A_(12);
    A_(21), A_(22)
  )
$

$
  B = mat(
    B_(11), B_(12);
    B_(21), B_(22)
  )
$

Each submatrix has dimensions

$
  n/2 times n/2
$

Ordinary block multiplication computes:

$
  C_(11) = A_(11) B_(11) + A_(12) B_(21)
$

$
  C_(12) = A_(11) B_(12) + A_(12) B_(22)
$

$
  C_(21) = A_(21) B_(11) + A_(22) B_(21)
$

$
  C_(22) = A_(21) B_(12) + A_(22) B_(22)
$

This requires *eight recursive matrix multiplications*.

The recurrence is

$
  T(n) = 8 T(n/2) + Theta(n^2)
$

Using the Master Theorem:

$
  d = log_2 8 = 3
$

Therefore,

$
  T(n) = Theta(n^3)
$

Ordinary divide and conquer provides no asymptotic improvement.

== 2.3 Strassen's Key Insight

Strassen replaces *eight recursive multiplications*
with only *seven*, using additional additions and
subtractions of submatrices.

The total addition/subtraction work remains $Theta(n^2)$.

Thus,

$
  T(n) = 7 T(n/2) + Theta(n^2)
$

Apply the Master Theorem:

$
  a = 7, quad b = 2, quad f(n) = Theta(n^2)
$

$
  d = log_2 7 approx 2.807
$

Since $n^2$ grows polynomially slower than $n^2.807$,
Case 1 applies.

#theorem[
  *Strassen's runtime:*

  $
    T(n) = Theta(n^(log_2 7))
  $

  $
    T(n) approx Theta(n^2.807)
  $
]

The important improvement is

$
  Theta(n^3) arrow Theta(n^2.807)
$

*Interpretation:* Saving one recursive multiplication
at every level reduces the total growth rate.

== 2.4 The Seven Products

Strassen constructs seven intermediate products:

$
  P_1 = A_(11) (B_(12) - B_(22))
$

$
  P_2 = (A_(11) + A_(12)) B_(22)
$

$
  P_3 = (A_(21) + A_(22)) B_(11)
$

$
  P_4 = A_(22) (B_(21) - B_(11))
$

$
  P_5 = (A_(11) + A_(22)) (B_(11) + B_(22))
$

$
  P_6 = (A_(12) - A_(22)) (B_(21) + B_(22))
$

$
  P_7 = (A_(11) - A_(21)) (B_(11) + B_(12))
$

The result is reconstructed using:

$
  C_(11) = P_5 + P_4 - P_2 + P_6
$

$
  C_(12) = P_1 + P_2
$

$
  C_(21) = P_3 + P_4
$

$
  C_(22) = P_5 + P_1 - P_3 - P_7
$

#example[
  *Why Strassen is faster asymptotically*

  Ordinary recursive multiplication:

  $
    T(n) = 8 T(n/2) + Theta(n^2)
    = Theta(n^3)
  $

  Strassen:

  $
    T(n) = 7 T(n/2) + Theta(n^2)
    = Theta(n^(log_2 7))
  $

  Reducing the branching factor changes the
  exponent of the runtime.
]

*Practical note:* Strassen introduces extra additions
and temporary storage. For small matrices, ordinary
optimized multiplication may be faster.

= 3. Linear-Time Selection

== 3.1 The Selection Problem

#definition[
  The *selection problem* asks for the $k$-th smallest
  element in an unsorted collection of $n$ elements.
]

#example[
  Given

  $
    A = (8, 3, 1, 7, 5)
  $

  and $k = 3$, the sorted order is

  $
    (1, 3, 5, 7, 8)
  $

  The third-smallest element is $5$.
]

Sorting first requires

$
  O(n log n)
$

However, selection does *not* require sorting the entire array.

The goal is a worst-case runtime of

$
  O(n)
$

== 3.2 Quickselect

Quickselect is similar to Quicksort:

+ Choose a pivot.
+ Partition around the pivot.
+ Determine which partition contains rank $k$.
+ Recurse only into that partition.

Unlike Quicksort, *only one side is recursively processed*.

For randomized Quickselect:

- Expected runtime: $O(n)$.
- Worst-case runtime: $O(n^2)$.

Poor pivot choices can repeatedly produce unbalanced partitions.

== 3.3 Median of Medians (BFPRT)

The median-of-medians algorithm chooses a pivot
that guarantees sufficient progress.

Algorithm:

+ Divide the input into groups of five elements.
+ Find the median of each group.
+ Recursively find the median of those medians.
+ Partition the original input around that pivot.
+ Recurse only into the side containing rank $k$.

This pivot does not have to be the exact median
of the original array.

== 3.4 Example

Suppose we have 25 elements divided into five groups.

After sorting each group:

$
  G_1 = (1, 7, 11, 19, 25)
$

$
  G_2 = (2, 8, 12, 20, 21)
$

$
  G_3 = (3, 9, 13, 17, 22)
$

$
  G_4 = (4, 10, 14, 18, 23)
$

$
  G_5 = (5, 6, 15, 16, 24)
$

Their medians are

$
  M = (11, 12, 13, 14, 15)
$

The median of these medians is

$
  x = 13
$

Therefore, $13$ becomes the partitioning pivot.

== 3.5 Why Groups of Five?

Consider a sorted group:

$
  a <= b <= c <= d <= e
$

Its median is $c$.

At least three elements are greater than or equal
to $c$, and three are less than or equal to $c$.

Approximately half of the group medians are at least
as large as the median of medians.

Therefore, at least roughly

$
  (1/2)(n/5)(3) = 3n/10
$

elements can be excluded from one side,
and similarly from the other side.

Accounting for incomplete groups, the guarantee is

$
  3n/10 - O(1)
$

elements on each side.

Thus the larger recursive partition contains at most

$
  7n/10 + O(1)
$

elements.

#theorem[
  *Pivot guarantee*

  Median of medians discards at least approximately
  $30%$ of the elements from consideration at each
  selection step.

  This prevents consistently poor partitions.
]

== 3.6 Runtime Analysis

The algorithm performs:

- $T(n/5)$: find the median of the group medians.
- $T(7n/10)$: recurse on the larger remaining partition.
- $O(n)$: group, find medians, and partition.

Ignoring rounding and additive constants, the recurrence is

$
  T(n) <= T(n/5) + T(7n/10) + O(n)
$

To show linear time, assume inductively that

$
  T(n) <= c n
$

and let the nonrecursive work be at most $d n$.

Substitute:

$
  T(n) <= c n/5 + 7 c n/10 + d n
$

$
  T(n) <= (9c/10 + d)n
$

Choosing $c >= 10d$ makes the bound at most $c n$.

The full induction handles small inputs and
rounding constants separately.

Therefore,

$
  T(n) = O(n)
$

Reading the input requires $Omega(n)$ work, giving

#theorem[
  *Median-of-medians selection:*

  $
    T(n) = Theta(n)
  $

  This is a worst-case bound, not merely an
  expected-time guarantee.
]

== 3.7 Why Selection Can Beat Sorting

Comparison sorting requires

$
  Omega(n log n)
$

comparisons in the worst case.

Selection requires only the element of a specified rank,
not the complete ordering.

Therefore, a comparison-based selection algorithm
can run in $Theta(n)$ time without contradicting
the sorting lower bound.

= 4. Multiple-Size Divide-and-Conquer Recurrences

== 4.1 Limitation of the Standard Master Theorem

The ordinary Master Theorem handles recurrences
such as

$
  T(n) = a T(n/b) + f(n)
$

where all recursive subproblems have the same size.

But consider:

$
  T(n) = T(n/5) + T(7n/10) + Theta(n)
$

The two recursive subproblems have different sizes.

Therefore, the standard theorem cannot be
directly applied.

== 4.2 Generalized Recurrence

Kao's multiple-size theorem handles recurrences
with several different subproblem-size fractions.

A representative form is

$
  T(n) =
  sum_(i=1)^k a_i T(ceil(b_i n))
  + Theta(n^alpha log^beta n)
$

where:

- $a_i > 0$: recursive-call coefficient.
- $0 < b_i < 1$: fraction of the input in a call.
- $alpha >= 0$: polynomial exponent of nonrecursive work.
- $beta >= 0$: logarithmic exponent of nonrecursive work.

The recurrence uses constant-sized base cases.

== 4.3 Characteristic Equation

Define $r$ as the real solution satisfying

$
  sum_(i=1)^k a_i b_i^r = 1
$

This is the *characteristic equation*.

#theorem[
  *Multiple-size Master Theorem*

  Suppose

  $
    T(n) =
    sum_(i=1)^k a_i T(ceil(b_i n))
    + Theta(n^alpha log^beta n)
  $

  under the theorem's standard assumptions.

  Let $r$ satisfy

  $
    sum_(i=1)^k a_i b_i^r = 1
  $

  Then:

  *Case 1:* If $r > alpha$,

  $
    T(n) = Theta(n^r)
  $

  *Case 2:* If $r = alpha$,

  $
    T(n) = Theta(n^alpha log^(beta + 1) n)
  $

  *Case 3:* If $r < alpha$,

  $
    T(n) = Theta(n^alpha log^beta n)
  $
]

*Interpretation:* The characteristic exponent $r$
captures the contribution of the recursive subproblems.

Comparing $r$ to $alpha$ determines whether recursion
or nonrecursive work dominates.

== 4.4 Example: Linear-Time Selection

Consider the simplified recurrence

$
  T(n) = T(n/5) + T(7n/10) + Theta(n)
$

Here,

$
  alpha = 1, quad beta = 0
$

The characteristic equation is

$
  (1/5)^r + (7/10)^r = 1
$

Evaluate the left side at $r = 1$:

$
  1/5 + 7/10 = 9/10 < 1
$

Since the left side decreases as $r$ increases,
the solution must satisfy

$
  r < 1
$

Thus,

$
  r < alpha
$

Case 3 applies:

$
  T(n) = Theta(n)
$

This agrees with the linear-time selection analysis.

For the actual algorithm's upper-bound recurrence,
the argument gives $O(n)$; reading the input supplies
the matching lower bound.

== 4.5 Example: Unequal-Sized Merge Recursion

Consider

$
  T(n) = T(n/3) + T(2n/3) + Theta(n)
$

The characteristic equation is

$
  (1/3)^r + (2/3)^r = 1
$

Testing $r = 1$ gives

$
  1/3 + 2/3 = 1
$

Therefore,

$
  r = 1 = alpha
$

Case 2 applies:

$
  T(n) = Theta(n log n)
$

#example[
  *Comparing two recurrences*

  Selection:

  $
    T(n) = T(n/5) + T(7n/10) + Theta(n)
  $

  The recursive size fractions total $0.9$:

  $
    T(n) = Theta(n)
  $

  Unequal-sized merge recursion:

  $
    T(n) = T(n/3) + T(2n/3) + Theta(n)
  $

  The recursive fractions total $1$:

  $
    T(n) = Theta(n log n)
  $

  This shortcut applies to these linear-work examples.
  For the general case, use the characteristic equation.
]

= 5. Comparison of Algorithms

#table(
  columns: (1.3fr, 2.2fr, 1fr),
  inset: 6pt,
  align: left,
  [*Algorithm*], [*Recurrence*], [*Runtime*],
  [Ordinary matrix multiplication], [$8T(n/2) + Theta(n^2)$], [$Theta(n^3)$],
  [Strassen], [$7T(n/2) + Theta(n^2)$], [$Theta(n^2.807)$],
  [Median of medians], [$T(n/5) + T(7n/10) + O(n)$], [$Theta(n)$],
  [Unequal-sized recursion], [$T(n/3) + T(2n/3) + Theta(n)$], [$Theta(n log n)$],
)

= 6. Important Takeaways

#callout("Key Concepts", [
  *1. Strassen:* Replacing eight recursive multiplications
  with seven reduces the asymptotic exponent.

  *2. Median of medians:* Choosing a guaranteed-good pivot
  gives worst-case linear-time selection.

  *3. Multiple-size theorem:* Different recursive input
  sizes require a generalized recurrence analysis.

  *4. Main lesson:* The structure of recursion determines
  how computation grows.
])

== Questions to Practice

+ Why does reducing eight matrix multiplications to seven
  improve the asymptotic runtime?

+ Why does median of medians guarantee that approximately
  $30%$ of the input can be discarded?

+ Why can selection achieve $Theta(n)$ while general
  comparison sorting requires $Omega(n log n)$?

+ Determine the asymptotic runtime:

  $
    T(n) = T(n/3) + T(2n/3) + n
  $

+ Determine the asymptotic runtime:

  $
    T(n) = 7 T(n/2) + n^2
  $

= References

- Mark Allen Weiss, _Data Structures and Algorithm Analysis
  in C++_, 4th edition, Section 10.2.

- Cormen, Leiserson, Rivest, and Stein,
  _Introduction to Algorithms_, 3rd edition,
  Sections 4.2, 4.5, and 9.3.

- #link("https://en.wikipedia.org/wiki/Strassen_algorithm")[
    Strassen's Algorithm
  ]

- #link("https://en.wikipedia.org/wiki/Median_of_medians")[
    Median of Medians
  ]

- #link("https://arxiv.org/pdf/cs/0101011")[
    Ming-Yang Kao — Multiple-Size Divide-and-Conquer Recurrences
  ]
