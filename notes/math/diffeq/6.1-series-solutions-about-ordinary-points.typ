#import "/templates/academic.typ": *
#show: academic.with(
  title: "6.1 Series Solutions About Ordinary Points",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 6.1 Series Solutions About Ordinary Points

== 1. Motivation: Why use power series?

Some differential equations cannot be solved using elementary functions. A useful example is

$
  y'' + x y = 0.
$

This is a form of *Airy's equation*. Its solutions can be written using special functions, but we can also construct them directly as power series.

*Main idea:* Assume that the unknown function is an infinite polynomial, substitute it into the differential equation, and determine its coefficients.

== 2. Review of power series

#definition[
  A *power series centered at* $a$ is an expression of the form

  $
    sum_(n=0)^infinity c_n (x-a)^n
    = c_0 + c_1(x-a) + c_2(x-a)^2 + dots.
  $

  When $a=0$, it is called a *Maclaurin series*.
]

The series *converges* at a particular $x$ when its partial sums

$
  S_N(x) = sum_(n=0)^N c_n (x-a)^n
$

approach a finite limit as $N -> infinity$.

=== Radius and interval of convergence

#definition[
  The *radius of convergence* $R$ is a number in $[0, infinity]$ such that:

  - the series converges absolutely if $|x-a| < R$;
  - the series diverges if $|x-a| > R$.

  When $0 < R < infinity$, the endpoints $x=a-R$ and $x=a+R$ must be tested separately. The resulting set of real $x$-values is the *interval of convergence*.
]

*Radius versus interval:* $R$ tells you the distance from the center, while the interval tells you which endpoints are included.

=== Absolute and conditional convergence

A series $sum_(n=0)^infinity c_n (x-a)^n$ *converges absolutely* when

$
  sum_(n=0)^infinity |c_n| |x-a|^n
$

converges. It *converges conditionally* when the original series converges but the absolute-value series diverges.

=== Finding the radius with the ratio test

If the following coefficient-ratio limit exists,

$
  L = lim_(n -> infinity) |frac(c_(n+1), c_n)|,
$

then, for $0 < L < infinity$,

$
  R = frac(1, L).
$

The limiting cases are $L=0 => R=infinity$ and $L=infinity => R=0$.

*Why?* The ratio of consecutive absolute-value terms approaches

$
  lim_(n -> infinity)
  |frac(c_(n+1)(x-a)^(n+1), c_n(x-a)^n)|
  = L |x-a|.
$

The ratio test gives convergence whenever $L|x-a| < 1$.

*Important:* If many $c_n$ are zero, the coefficient-ratio limit may not be usable. A different test or a direct analysis of the recurrence may be needed.

=== Identity property

#theorem[
  If

  $
    sum_(n=0)^infinity c_n (x-a)^n = 0
  $

  for every $x$ in an open interval around $a$, then $c_n=0$ for every $n$.
]

This lets us set the coefficient of *each power of* $x$ equal to zero after substituting a power series into a differential equation.

== 3. Maclaurin series worth remembering

$
  e^x = sum_(n=0)^infinity frac(x^n, n!)
  = 1+x+frac(x^2, 2!)+frac(x^3, 3!)+dots
$

$
  cos x = sum_(n=0)^infinity frac((-1)^n x^(2n), (2n)!)
  = 1-frac(x^2, 2!)+frac(x^4, 4!)-dots
$

$
  sin x = sum_(n=0)^infinity frac((-1)^n x^(2n+1), (2n+1)!)
  = x-frac(x^3, 3!)+frac(x^5, 5!)-dots
$

All three have radius $R=infinity$.

The *geometric series* is

$
  frac(1, 1-x) = sum_(n=0)^infinity x^n
  = 1+x+x^2+dots,
  quad |x|<1.
$

It has radius $R=1$ and interval of convergence $(-1,1)$.

The *logarithm series* is

$
  ln(1+x) = sum_(n=1)^infinity frac((-1)^(n+1)x^n, n)
  = x-frac(x^2, 2)+frac(x^3, 3)-dots,
  quad -1<x<=1.
$

It has radius $R=1$ and interval of convergence $(-1,1]$.

== 4. Worked examples: Radius and interval of convergence

=== Example 1: Alternating power-series coefficients

Find the radius and interval of convergence of

$
  sum_(n=1)^infinity frac((-1)^n x^n, n).
$

*Step 1: Identify the coefficients.*

$
  c_n = frac((-1)^n, n).
$

*Step 2: Apply the ratio test.*

$
  L = lim_(n -> infinity) |frac(c_(n+1), c_n)|
  = lim_(n -> infinity) frac(n, n+1) = 1.
$

Therefore $R=1$, so the series converges absolutely for $|x|<1$.

*Step 3: Test the endpoints separately.*

- At $x=1$, we get $sum_(n=1)^infinity frac((-1)^n, n)$, which converges *conditionally* by the alternating series test.
- At $x=-1$, we get $sum_(n=1)^infinity frac(1, n)$, which *diverges* (harmonic series).

*Answer:*

$
  R=1, quad "interval"=(-1,1].
$

*Correction to the handwritten notes:* The endpoint $x=-1$ diverges; it is not included in the interval.

=== Example 2: A scaled harmonic series

Find the radius and interval of convergence of

$
  sum_(n=1)^infinity frac(x^n, n 2^n).
$

*Step 1: Identify the coefficients.*

$
  c_n = frac(1, n 2^n).
$

*Step 2: Apply the ratio test.*

$
  L = lim_(n -> infinity) frac(n 2^n, (n+1)2^(n+1))
  = lim_(n -> infinity) frac(n, 2(n+1))
  = frac(1, 2).
$

Thus $R=2$ and the series converges absolutely for $|x|<2$.

*Step 3: Test the endpoints.*

- At $x=2$, the series becomes $sum_(n=1)^infinity frac(1, n)$, which diverges.
- At $x=-2$, the series becomes $sum_(n=1)^infinity frac((-1)^n, n)$, which converges conditionally.

*Answer:*

$
  R=2, quad "interval"=[-2,2).
$

== 5. Analytic functions and ordinary points

#definition[
  A function $f$ is *analytic at* $a$ if it agrees with its Taylor series in some open interval around $a$:

  $
    f(x) = sum_(n=0)^infinity frac(f^(n)(a), n!) (x-a)^n.
  $
]

Consider a second-order *linear homogeneous differential equation*:

$
  a_2(x)y'' + a_1(x)y' + a_0(x)y = 0.
$

Where $a_2(x) != 0$, divide by the leading coefficient to obtain standard form:

$
  y'' + P(x)y' + Q(x)y = 0,
$

where

$
  P(x) = frac(a_1(x), a_2(x)),
  quad Q(x) = frac(a_0(x), a_2(x)).
$

#definition[
  A point $x_0$ is an *ordinary point* if both $P(x)$ and $Q(x)$ are analytic at $x_0$. Otherwise, it is a *singular point*.
]

When $a_0$, $a_1$, and $a_2$ are polynomials with no common factor, $x_0$ is an ordinary point exactly when $a_2(x_0) != 0$.

=== Existence theorem for ordinary points

#theorem[
  If $x_0$ is an ordinary point of a second-order linear homogeneous equation, then it has two linearly independent power-series solutions centered at $x_0$.

  Their series converge at least for $|x-x_0|<R$, where $R$ is the distance to the nearest finite singularity of $P$ or $Q$ in the *complex plane*.
]

*Why complex singularities matter:* Even when solving for real $x$, a singularity off the real axis can limit the convergence of a Taylor series.

*Example:* For $y'' + x y = 0$, we have $P(x)=0$ and $Q(x)=x$. Both are polynomials, so every finite point is ordinary. The power-series solutions centered at zero have infinite radius of convergence.

== 6. Solving Airy's equation by power series

Solve

$
  y'' + x y = 0
$

about the ordinary point $x_0=0$.

=== Step 1: Assume a power-series solution

$
  y = sum_(n=0)^infinity c_n x^n.
$

Differentiate term by term:

$
  y' = sum_(n=1)^infinity n c_n x^(n-1),
$

$
  y'' = sum_(n=2)^infinity n(n-1)c_n x^(n-2).
$

=== Step 2: Substitute into the equation

$
  sum_(n=2)^infinity n(n-1)c_n x^(n-2)
  + sum_(n=0)^infinity c_n x^(n+1) = 0.
$

The exponents in these two sums differ. To combine them, *reindex* each sum so both use powers of $x^k$.

=== Step 3: Reindex both sums

For the first sum, let $k=n-2$, or $n=k+2$:

$
  y'' = sum_(k=0)^infinity (k+2)(k+1)c_(k+2)x^k.
$

For the second sum, let $k=n+1$, or $n=k-1$:

$
  x y = sum_(k=1)^infinity c_(k-1)x^k.
$

Notice that *the first sum starts at* $k=0$, while *the second starts at* $k=1$. Separate the constant term before combining them:

$
  2c_2 + sum_(k=1)^infinity
  ((k+2)(k+1)c_(k+2) + c_(k-1))x^k = 0.
$

=== Step 4: Equate coefficients to zero

By the identity property,

$
  2c_2=0 quad => quad c_2=0,
$

and for every integer $k>=1$,

$
  (k+2)(k+1)c_(k+2) + c_(k-1)=0.
$

Solving for the next coefficient gives the *recurrence relation*:

#definition[
  $
    c_(k+2) = -frac(c_(k-1), (k+2)(k+1)),
    quad k>=1,
  $

  with $c_2=0$ and free constants $c_0$ and $c_1$.
]

*Interpretation:* Every coefficient is determined by the coefficient *three indices earlier*. Therefore the nonzero coefficients form two separate chains, one starting with $c_0$ and the other with $c_1$. The chain starting with $c_2$ is zero.

=== Step 5: Compute the first coefficients

- $k=1$: $c_3 = -frac(1, 6)c_0$.
- $k=2$: $c_4 = -frac(1, 12)c_1$.
- $k=3$: $c_5 = -frac(1, 20)c_2 = 0$.
- $k=4$: $c_6 = -frac(1, 30)c_3 = frac(1, 180)c_0$.
- $k=5$: $c_7 = -frac(1, 42)c_4 = frac(1, 504)c_1$.
- $k=6$: $c_8 = -frac(1, 56)c_5 = 0$.
- $k=7$: $c_9 = -frac(1, 72)c_6 = -frac(1, 12960)c_0$.
- $k=8$: $c_10 = -frac(1, 90)c_7 = -frac(1, 45360)c_1$.

The coefficient chains are

$
  c_0 -> c_3 -> c_6 -> c_9 -> dots
$

and

$
  c_1 -> c_4 -> c_7 -> c_10 -> dots.
$

Meanwhile, $c_2=c_5=c_8=dots=0$.

=== Step 6: Write the general solution

Insert the coefficients into $y=sum_(n=0)^infinity c_n x^n$:

$
  y = c_0 + c_1 x - frac(c_0, 6)x^3
  - frac(c_1, 12)x^4
  + frac(c_0, 180)x^6
  + frac(c_1, 504)x^7
  - frac(c_0, 12960)x^9
  - frac(c_1, 45360)x^10 + dots.
$

Group the terms multiplying each free constant:

$
  y(x) = c_0 y_1(x) + c_1 y_2(x),
$

where

$
  y_1(x) = 1 - frac(x^3, 6) + frac(x^6, 180)
  - frac(x^9, 12960) + dots,
$

$
  y_2(x) = x - frac(x^4, 12) + frac(x^7, 504)
  - frac(x^10, 45360) + dots.
$

These are two linearly independent solutions because

$
  y_1(0)=1, quad y_1'(0)=0,
$

$
  y_2(0)=0, quad y_2'(0)=1.
$

Thus $c_0=y(0)$ and $c_1=y'(0)$: the two free coefficients encode the two initial conditions for a second-order equation.

*Convergence:* Since $P(x)=0$ and $Q(x)=x$ are analytic everywhere in the complex plane, both power-series solutions converge for every real $x$ ($R=infinity$).

== 7. General strategy for series solutions

When asked to solve a differential equation using a power series:

+ Put the equation in standard form and check that the center $x_0$ is an ordinary point.
+ Assume $y=sum_(n=0)^infinity c_n (x-x_0)^n$.
+ Differentiate as needed and substitute into the equation.
+ Reindex all sums to powers of the same variable, usually $(x-x_0)^k$.
+ Separate any terms whose lower summation indices do not match.
+ Use the identity property to obtain a recurrence for the coefficients.
+ Determine several coefficients in terms of the free constants.
+ Group the terms into independent solutions and state the convergence information.

*Three common mistakes to avoid:*

- Forgetting to change the *starting index* when reindexing a sum.
- Treating $c_0$ and $c_1$ as zero: they are generally free constants.
- Including an endpoint of a convergence interval without testing the series there.

== 8. Quick self-check

*Question 1.* For $sum_(n=1)^infinity frac(x^n, n 3^n)$, find the radius and interval of convergence.

*Question 2.* In the Airy recurrence, why do the coefficients $c_2,c_5,c_8,dots$ all vanish?

*Question 3.* If a second-order equation is in standard form with $P(x)=frac(1, 1+x^2)$ and $Q(x)=0$, what lower bound can you guarantee for the radius of a series centered at $x_0=0$?

=== Answers

1. $R=3$ and the interval is $[-3,3)$: at $x=-3$ the alternating harmonic series converges, while at $x=3$ the harmonic series diverges.
2. Since $c_2=0$ and the recurrence takes each coefficient from three indices earlier, it forces $c_5=c_8=c_11=dots=0$.
3. $R>=1$. The nearest complex singularities of $P(x)$ occur at $x=i$ and $x=-i$, each one unit away from the origin.
