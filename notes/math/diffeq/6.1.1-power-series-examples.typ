#import "/templates/academic.typ": *
#show: academic.with(
  title: "Power Series Solutions",
  course: "Differential Equations",
  semester: "Fall 2026",
)

== Worked Examples: Power Series Solutions

=== Example 3: Combining Two Power Series

Write the following expression as a single power series:

$
  S_1 = sum_(n=1)^infinity 2 n c_n x^(n-1)
  + sum_(n=0)^infinity 6 c_n x^(n+1)
$

*Solution.*

Examine the first terms of each summation.

First series:

$
  n = 1: quad 2 c_1 x^0
$

$
  n = 2: quad 4 c_2 x^1
$

Second series:

$
  n = 0: quad 6 c_0 x^1
$

$
  n = 1: quad 6 c_1 x^2
$

Separate the constant term:

$
  S_1 = 2 c_1
  + sum_(n=2)^infinity 2 n c_n x^(n-1)
  + sum_(n=0)^infinity 6 c_n x^(n+1)
$

*Reindex the first summation.*

Let $k = n - 1$, so $n = k + 1$.

$
  sum_(n=2)^infinity 2 n c_n x^(n-1)
  = sum_(k=1)^infinity 2(k+1)c_(k+1)x^k
$

*Reindex the second summation.*

Let $k = n + 1$, so $n = k - 1$.

$
  sum_(n=0)^infinity 6 c_n x^(n+1)
  = sum_(k=1)^infinity 6 c_(k-1)x^k
$

Now both summations have the same index and exponent.

$
  S_1 = 2 c_1
  + sum_(k=1)^infinity 2(k+1)c_(k+1)x^k
  + sum_(k=1)^infinity 6c_(k-1)x^k
$

*Final answer:*

$
  S_1 = 2c_1
  + sum_(k=1)^infinity
  (2(k+1)c_(k+1) + 6c_(k-1))x^k
$

=== Example 4: Combining Series with Subtraction

Write the following expression as a single power series:

$
  S_2 = sum_(n=1)^infinity n c_n x^(n-1)
  - 3 sum_(n=0)^infinity c_n x^(n+1)
$

*Solution.*

The first summation begins with $c_1 x^0$.

Separate the constant term:

$
  S_2 = c_1
  + sum_(n=2)^infinity n c_n x^(n-1)
  - sum_(n=0)^infinity 3c_n x^(n+1)
$

*First summation.*

Let $k = n - 1$, so $n = k + 1$.

$
  sum_(n=2)^infinity n c_n x^(n-1)
  = sum_(k=1)^infinity (k+1)c_(k+1)x^k
$

*Second summation.*

Let $k = n + 1$, so $n = k - 1$.

$
  sum_(n=0)^infinity 3c_n x^(n+1)
  = sum_(k=1)^infinity 3c_(k-1)x^k
$

Substitute:

$
  S_2 = c_1
  + sum_(k=1)^infinity (k+1)c_(k+1)x^k
  - sum_(k=1)^infinity 3c_(k-1)x^k
$

*Final answer:*

$
  S_2 = c_1
  + sum_(k=1)^infinity
  ((k+1)c_(k+1) - 3c_(k-1))x^k
$

=== Example 5: Solving a Differential Equation

Solve using a power series centered at $x = 0$:

$
  (x^2 + 1)y'' + x y' - y = 0
$

*Step 1: Assume a power series solution.*

$
  y = sum_(n=0)^infinity c_n x^n
$

Differentiate:

$
  y' = sum_(n=1)^infinity n c_n x^(n-1)
$

$
  y'' = sum_(n=2)^infinity n(n-1)c_n x^(n-2)
$

*Step 2: Substitute into the differential equation.*

$
  (x^2+1)sum_(n=2)^infinity n(n-1)c_n x^(n-2)
  + x sum_(n=1)^infinity n c_n x^(n-1)
  - sum_(n=0)^infinity c_n x^n = 0
$

Distribute and simplify powers:

$
  sum_(n=2)^infinity n(n-1)c_n x^n
  + sum_(n=2)^infinity n(n-1)c_n x^(n-2)
  + sum_(n=1)^infinity n c_n x^n
  - sum_(n=0)^infinity c_n x^n = 0
$

*Step 3: Separate constant and linear terms.*

From the second summation:

$
  n = 2: quad 2c_2 x^0
$

$
  n = 3: quad 6c_3 x^1
$

From the third summation:

$
  n = 1: quad c_1 x^1
$

From the fourth summation:

$
  n = 0: quad -c_0 x^0
$

$
  n = 1: quad -c_1 x^1
$

The $c_1 x$ terms cancel.

We obtain:

$
  (2c_2-c_0)+6c_3 x
  + sum_(n=2)^infinity n(n-1)c_n x^n
  + sum_(n=4)^infinity n(n-1)c_n x^(n-2)
  + sum_(n=2)^infinity n c_n x^n
  - sum_(n=2)^infinity c_n x^n = 0
$

*Step 4: Reindex the second summation.*

Let $k = n - 2$, so $n = k + 2$.

$
  sum_(n=4)^infinity n(n-1)c_n x^(n-2)
  = sum_(k=2)^infinity (k+2)(k+1)c_(k+2)x^k
$

Rename $k$ to $n$ and combine:

$
  (2c_2-c_0)+6c_3 x
  + sum_(n=2)^infinity
  (n(n-1)c_n + (n+2)(n+1)c_(n+2)
    + n c_n - c_n)x^n = 0
$

Simplify the coefficient:

$
  n(n-1)c_n + n c_n - c_n = (n^2-1)c_n
$

Therefore:

$
  (2c_2-c_0)+6c_3 x
  + sum_(n=2)^infinity
  ((n^2-1)c_n + (n+2)(n+1)c_(n+2))x^n = 0
$

*Step 5: Equate coefficients to zero.*

Constant term:

$
  2c_2-c_0 = 0
$

$
  c_2 = c_0/2
$

Linear term:

$
  6c_3 = 0
$

$
  c_3 = 0
$

For $n >= 2$:

$
  (n^2-1)c_n + (n+2)(n+1)c_(n+2) = 0
$

Solve for $c_(n+2)$:

$
  c_(n+2) = -frac(n^2-1, (n+2)(n+1))c_n
$

Factor the numerator:

$
  c_(n+2) = -frac((n-1)(n+1), (n+2)(n+1))c_n
$

*Recurrence relation:*

$
  c_(n+2) = -frac(n-1, n+2)c_n
$

*Step 6: Calculate the coefficients.*

The constants $c_0$ and $c_1$ are arbitrary.

We already know:

$
  c_2 = c_0/2, quad c_3 = 0
$

For $n = 2$:

$
  c_4 = -frac(1, 4)c_2 = -frac(1, 8)c_0
$

For $n = 3$:

$
  c_5 = -frac(2, 5)c_3 = 0
$

For $n = 4$:

$
  c_6 = -frac(3, 6)c_4 = frac(1, 16)c_0
$

Notice that all odd coefficients beyond $c_1$ are zero.

*Step 7: Construct the solution.*

Recall:

$
  y = sum_(n=0)^infinity c_n x^n
$

Expand:

$
  y = c_0 + c_1 x + c_2 x^2 + c_3 x^3
  + c_4 x^4 + c_5 x^5 + c_6 x^6 + dots
$

Substitute the coefficients:

$
  y = c_0 + c_1 x + frac(c_0, 2)x^2
  - frac(c_0, 8)x^4 + frac(c_0, 16)x^6 + dots
$

Group by arbitrary constants:

$
  y = c_0(1 + frac(1, 2)x^2 - frac(1, 8)x^4
    + frac(1, 16)x^6 + dots) + c_1 x
$

Thus, the two independent solutions are:

$
  y_1 = 1 + frac(1, 2)x^2 - frac(1, 8)x^4
  + frac(1, 16)x^6 + dots
$

$
  y_2 = x
$

The general solution is:

$
  y = c_0 y_1 + c_1 y_2
$

*Observation.*

The first solution is the binomial series for $sqrt(1+x^2)$.

Therefore, the closed-form solution is:

$
  y = c_0 sqrt(1+x^2) + c_1 x
$

The power series centered at $x=0$ converges for $abs(x) < 1$.
