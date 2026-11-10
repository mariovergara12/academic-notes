#import "/templates/academic.typ": *

#show: academic.with(
  title: "Karatsuba Multiplication",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 4, pp. 12–13

= Multiply Large Integers Faster

The traditional grade-school multiplication algorithm requires:

$
  Theta(n^2)
$

single-digit operations to multiply two integers containing $n$ digits.

*Karatsuba multiplication* is a divide-and-conquer algorithm that reduces four half-size multiplications to only three.

This improves the asymptotic running time.

== Splitting the Numbers

Suppose we have two integers $x$ and $y$.

Split each integer into two approximately equal halves.

Let $B$ represent the base raised to the number of digits in the lower half.

Write:

$
  x = a B + b
$

$
  y = c B + d
$

Multiplying:

$
  x y = (a B + b)(c B + d)
$

Expanding:

$
  x y = a c B^2 + (a d + b c) B + b d
$

The traditional approach requires four multiplications:

- $a c$
- $a d$
- $b c$
- $b d$

Karatsuba reduces this to three.

== Karatsuba's Key Idea

Instead of computing $a d$ and $b c$ separately, define:

$
  p = a c
$

$
  q = b d
$

$
  r = (a + b)(c + d)
$

Expanding $r$:

$
  r = a c + a d + b c + b d
$

Since $p = a c$ and $q = b d$:

$
  a d + b c = r - p - q
$

Substituting into the original multiplication formula:

$
  x y = p B^2 + (r - p - q) B + q
$

This is the *Karatsuba identity*.

It requires only three recursive multiplications instead of four.

== Worked Example: 1234 Times 5678

We want to compute:

$
  1234 times 5678
$

=== Step 1: Split the Numbers

Split each number into two groups of two decimal digits.

Therefore:

$
  B = 100
$

Write:

$
  1234 = 12 times 100 + 34
$

$
  5678 = 56 times 100 + 78
$

Thus:

$
  a = 12, quad b = 34
$

$
  c = 56, quad d = 78
$

=== Step 2: Calculate the Three Products

First product:

$
  p = a c = 12 times 56 = 672
$

Second product:

$
  q = b d = 34 times 78 = 2652
$

Third product:

$
  r = (a + b)(c + d)
$

Substitute:

$
  r = (12 + 34)(56 + 78)
$

$
  r = 46 times 134 = 6164
$

=== Step 3: Calculate the Middle Term

Recall:

$
  a d + b c = r - p - q
$

Substitute:

$
  r - p - q = 6164 - 672 - 2652
$

Therefore:

$
  r - p - q = 2840
$

=== Step 4: Reconstruct the Product

Use the Karatsuba identity:

$
  x y = p B^2 + (r - p - q) B + q
$

Substitute:

$
  x y = 672 times 100^2 + 2840 times 100 + 2652
$

Simplify:

$
  x y = 6720000 + 284000 + 2652
$

Therefore:

$
  x y = 7006652
$

Our final result is:

$
  1234 times 5678 = 7006652
$

== Runtime Analysis

Karatsuba performs:

- Three recursive multiplications on approximately half-size inputs.
- A linear amount of additional work for additions, subtractions, and digit shifts.

Therefore, the recurrence is:

$
  T(n) = 3 T(n / 2) + Theta(n)
$

We can solve this using the Master Theorem.

The parameters are:

$
  a = 3, quad b = 2
$

$
  f(n) = Theta(n)
$

The critical exponent is:

$
  log_b a = log_2 3
$

Since:

$
  log_2 3 approx 1.585
$

and:

$
  n = O(n^(log_2 3 - epsilon))
$

for some constant $epsilon > 0$, Master Theorem Case 1 applies.

Therefore:

$
  T(n) = Theta(n^(log_2 3))
$

Approximately:

$
  T(n) = Theta(n^1.585)
$

== Comparison with Traditional Multiplication

#table(
  columns: (1.3fr, 1fr),
  [*Algorithm*], [*Running Time*],
  [Grade-School Multiplication], [$Theta(n^2)$],
  [Karatsuba Multiplication], [$Theta(n^(log_2 3))$],
)

Karatsuba is asymptotically faster because:

$
  log_2 3 < 2
$

However, for small inputs, traditional multiplication can still be faster due to lower overhead.

== Important Takeaways

- Karatsuba is a divide-and-conquer multiplication algorithm.
- It splits two integers into approximately equal halves.
- Traditional multiplication requires four half-size products.
- Karatsuba requires only three.
- The key identity is:

  $
    a d + b c = (a + b)(c + d) - a c - b d
  $

- Its recurrence is:

  $
    T(n) = 3 T(n / 2) + Theta(n)
  $

- Its asymptotic running time is:

  $
    Theta(n^(log_2 3))
  $

*Exam Focus:* Understand how the algebraic identity eliminates one recursive multiplication and why that changes the recurrence from four subproblems to three.
