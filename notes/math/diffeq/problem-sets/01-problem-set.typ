
#import "/templates/academic.typ": academic, callout

#show: academic.with(
  title: "Differential Equations: Problem Set 1 ",
  course: "MATH 3341 — Differential Equations",
  semester: "Fall 2026",
)

#text(size: 9pt, fill: rgb("#64748B"))[
  November 17, 2026 — Undetermined Coefficients
  and Variation of Parameters
]

These notes organize six worked problems from today's practice,
covering polynomial forcing, resonance, repeated roots, mixed
forcing terms, initial-value problems, and variation of parameters.

= Undetermined Coefficients

For a constant-coefficient differential equation

$ L(y) = g(x) $

first solve the homogeneous equation to obtain $y_h$.
Next, choose a particular solution $y_p$ based on the
forcing function $g(x)$.

The general solution is

$ y = y_h + y_p $

#callout("Resonance Rule", [
  If the proposed particular solution overlaps with
  the homogeneous solution, multiply the trial by $x$.

  If the corresponding characteristic root is repeated
  twice, multiply the trial by $x^2$ instead.
])

== Problem 1: Polynomial Forcing

*Given:*

$ y'' + 3 y' + 2 y = 6 x^2 - 4 x + 1 $

*Step 1: Homogeneous solution.*

The characteristic equation is

$
   r^2 + 3 r + 2 & = 0 \
  (r + 1)(r + 2) & = 0
$

Therefore, $r = -1$ and $r = -2$.

$
  y_h = C_1 e^(-x) + C_2 e^(-2 x)
$

*Step 2: Particular solution.*

Since the forcing function is a polynomial of degree two,
assume

$
  y_p = A x^2 + B x + C
$

Differentiate:

$
   y_p' & = 2 A x + B \
  y_p'' & = 2 A
$

Substitute:

$
     2 A + 3(2 A x + B) + 2(A x^2 + B x + C) & = 6 x^2 - 4 x + 1 \
  2 A x^2 + (6 A + 2 B)x + (2 A + 3 B + 2 C) & = 6 x^2 - 4 x + 1
$

*Step 3: Match coefficients.*

Coefficient of $x^2$:

$
  2 A & = 6 \
    A & = 3
$

Coefficient of $x$:

$
  6 A + 2 B & = -4 \
   18 + 2 B & = -4 \
          B & = -11
$

Constant term:

$
  2 A + 3 B + 2 C & = 1 \
     6 - 33 + 2 C & = 1 \
                C & = 14
$

Therefore,

$
  y_p = 3 x^2 - 11 x + 14
$

*General solution:*

$
  y = C_1 e^(-x) + C_2 e^(-2 x)
  + 3 x^2 - 11 x + 14
$

== Problem 2: Trigonometric Resonance

*Given:*

$
  y'' + 4 y = 10 sin(2 x)
$

*Step 1: Homogeneous solution.*

$
  r^2 + 4 & = 0 \
        r & = plus.minus 2 i
$

The roots are complex with $alpha = 0$ and $beta = 2$.

$
  y_h = C_1 cos(2 x) + C_2 sin(2 x)
$

*Step 2: Choose the particular solution.*

Normally, we would try

$
  y_p = A cos(2 x) + B sin(2 x)
$

However, these terms already occur in $y_h$.

Multiply by $x$:

$
  y_p = x(A cos(2 x) + B sin(2 x))
$

Expanding,

$
  y_p = A x cos(2 x) + B x sin(2 x)
$

*Step 3: Differentiate.*

First derivative:

$
  y_p' = A cos(2 x) - 2 A x sin(2 x)
  + B sin(2 x) + 2 B x cos(2 x)
$

Second derivative:

$
  y_p'' = -4 A sin(2 x) - 4 A x cos(2 x)
  + 4 B cos(2 x) - 4 B x sin(2 x)
$

*Step 4: Substitute.*

Using

$
  y_p'' + 4 y_p = 10 sin(2 x)
$

the terms containing $x$ cancel:

$
  -4 A sin(2 x) + 4 B cos(2 x)
  = 10 sin(2 x)
$

Matching coefficients:

$
  -4 A & = 10 \
     A & = -5/2
$

and

$
  4 B & = 0 \
    B & = 0
$

Therefore,

$
  y_p = -5/2 x cos(2 x)
$

*General solution:*

$
  y = C_1 cos(2 x) + C_2 sin(2 x)
  - 5/2 x cos(2 x)
$

== Problem 3: Repeated-Root Resonance

*Given:*

$
  y'' - 4 y' + 4 y = 5 e^(2 x)
$

*Step 1: Homogeneous solution.*

$
  r^2 - 4 r + 4 & = 0 \
      (r - 2)^2 & = 0
$

The characteristic root $r = 2$ has multiplicity two.

Therefore,

$
  y_h = C_1 e^(2 x) + C_2 x e^(2 x)
$

*Step 2: Particular solution.*

The usual trial is

$
  y_p = A e^(2 x)
$

However, both $e^(2 x)$ and $x e^(2 x)$ occur
in the homogeneous solution.

Therefore, multiply by $x^2$:

$
  y_p = A x^2 e^(2 x)
$

*Step 3: Differentiate.*

$
  y_p' = 2 A x e^(2 x) + 2 A x^2 e^(2 x)
$

The second derivative is

$
  y_p'' = 2 A e^(2 x)
  + 8 A x e^(2 x)
  + 4 A x^2 e^(2 x)
$

*Step 4: Substitute.*

$
  y_p'' - 4 y_p' + 4 y_p = 5 e^(2 x)
$

Substitution gives

$
  (2 A + 8 A x + 4 A x^2)e^(2 x)
  - 4(2 A x + 2 A x^2)e^(2 x)
  + 4 A x^2 e^(2 x) & = 5 e^(2 x) \
        2 A e^(2 x) & = 5 e^(2 x)
$

Therefore,

$
  2 A & = 5 \
    A & = 5/2
$

Thus,

$
  y_p = 5/2 x^2 e^(2 x)
$

*General solution:*

$
  y = C_1 e^(2 x) + C_2 x e^(2 x)
  + 5/2 x^2 e^(2 x)
$

== Problem 4: Mixed Forcing Terms

*Given:*

$
  y'' + 2 y' + 2 y = e^(-x) cos x + 3 x
$

*Step 1: Homogeneous solution.*

The characteristic equation is

$
  r^2 + 2 r + 2 = 0
$

Using the quadratic formula,

$
  r & = (-2 plus.minus sqrt(4 - 8))/2 \
    & = -1 plus.minus i
$

Therefore,

$
  y_h = e^(-x)(C_1 cos x + C_2 sin x)
$

*Step 2: Choose the particular solution.*

The forcing function contains two terms:

$
  g(x) = e^(-x) cos x + 3 x
$

The exponential-trigonometric term overlaps with $y_h$,
while the polynomial term does not.

Therefore,

$
  y_p = x e^(-x)(A cos x + B sin x) + C x + D
$

*Step 3: Exponential-trigonometric part.*

Let

$
  y_(p 1) = e^(-x) f(x)
$

where

$
  f(x) = x(A cos x + B sin x)
$

For the operator

$
  L(y) = y'' + 2 y' + 2 y
$

we have

$
  L(e^(-x) f(x)) = e^(-x)(f''(x) + f(x))
$

Differentiate:

$
  f'(x) = A cos x - A x sin x
  + B sin x + B x cos x
$

Then

$
  f''(x) = -2 A sin x - A x cos x
  + 2 B cos x - B x sin x
$

Adding $f(x)$:

$
  f''(x) + f(x) = -2 A sin x + 2 B cos x
$

Therefore,

$
  e^(-x)(-2 A sin x + 2 B cos x)
  = e^(-x) cos x
$

Matching coefficients:

$
  -2 A & = 0 \
     A & = 0
$

and

$
  2 B & = 1 \
    B & = 1/2
$

Thus,

$
  y_(p 1) = 1/2 x e^(-x) sin x
$

*Step 4: Polynomial part.*

Assume

$
  y_(p 2) = C x + D
$

Then

$
   y_(p 2)' & = C \
  y_(p 2)'' & = 0
$

Substitute:

$
  2 C + 2(C x + D) = 3 x
$

Matching coefficients:

$
  2 C & = 3 \
    C & = 3/2
$

and

$
  2 C + 2 D & = 0 \
    3 + 2 D & = 0 \
          D & = -3/2
$

Therefore,

$
  y_(p 2) = 3/2 x - 3/2
$

The complete particular solution is

$
  y_p = 1/2 x e^(-x) sin x + 3/2 x - 3/2
$

*General solution:*

$
  y = e^(-x)(C_1 cos x + C_2 sin x)
  + 1/2 x e^(-x) sin x
  + 3/2 x - 3/2
$

== Problem 5: Initial-Value Problem

*Given:*

$
  y'' + 4 y' + 5 y = 20 e^(-4 x)
$

with initial conditions

$
  y(0) = -3, quad y'(0) = 1
$

*Step 1: Homogeneous solution.*

The characteristic equation is

$
  r^2 + 4 r + 5 = 0
$

Using the quadratic formula,

$
  r & = (-4 plus.minus sqrt(16 - 20))/2 \
    & = -2 plus.minus i
$

Therefore,

$
  y_h = e^(-2 x)(C_1 cos x + C_2 sin x)
$

*Step 2: Particular solution.*

Since $-4$ is not a characteristic root, try

$
  y_p = A e^(-4 x)
$

Differentiate:

$
   y_p' & = -4 A e^(-4 x) \
  y_p'' & = 16 A e^(-4 x)
$

Substituting,

$
  16 A e^(-4 x) - 16 A e^(-4 x)
  + 5 A e^(-4 x) & = 20 e^(-4 x) \
             5 A & = 20 \
               A & = 4
$

Therefore,

$
  y_p = 4 e^(-4 x)
$

The general solution is

$
  y = e^(-2 x)(C_1 cos x + C_2 sin x)
  + 4 e^(-4 x)
$

*Step 3: Apply $y(0) = -3$.*

$
   -3 & = C_1 + 4 \
  C_1 & = -7
$

*Step 4: Apply $y'(0) = 1$.*

Differentiate the general solution:

$
  y' = e^(-2 x)(
    -2 C_1 cos x - C_1 sin x
    -2 C_2 sin x + C_2 cos x
  ) - 16 e^(-4 x)
$

At $x = 0$:

$
  -2 C_1 + C_2 - 16 = 1
$

Substituting $C_1 = -7$:

$
  14 + C_2 - 16 & = 1 \
            C_2 & = 3
$

*Solution satisfying both initial conditions:*

$
  y = e^(-2 x)(-7 cos x + 3 sin x)
  + 4 e^(-4 x)
$

= Variation of Parameters

Variation of parameters can solve nonhomogeneous equations
when the forcing function does not have a convenient trial
form for undetermined coefficients.

Consider the equation in standard form:

$
  y'' + p(x) y' + q(x) y = g(x)
$

Suppose the homogeneous solutions are $y_1$ and $y_2$.

We seek a particular solution of the form

$
  y_p = u_1 y_1 + u_2 y_2
$

The Wronskian is

$
  W = y_1 y_2' - y_1' y_2
$

The formulas for the unknown functions are

$
  u_1' & = -(y_2 g(x))/W \
  u_2' & = (y_1 g(x))/W
$

Integrate these expressions to find $u_1$ and $u_2$.

#callout("Variation of Parameters", [
  First ensure that the coefficient of $y''$ is $1$.

  Then find the homogeneous solutions, calculate the
  Wronskian, integrate $u_1'$ and $u_2'$, and construct
  the particular solution.
])

== Problem 6: Forcing by $csc x$

*Given:*

$
  y'' + y = csc x, quad 0 < x < pi
$

*Step 1: Homogeneous solution.*

The characteristic equation is

$
  r^2 + 1 & = 0 \
        r & = plus.minus i
$

Thus,

$
  y_h = C_1 cos x + C_2 sin x
$

Choose

$
  y_1 = cos x, quad y_2 = sin x
$

*Step 2: Compute the Wronskian.*

Recall

$
  W = y_1 y_2' - y_1' y_2
$

Since

$
  y_1' = -sin x, quad y_2' = cos x
$

we obtain

$
  W & = (cos x)(cos x) - (-sin x)(sin x) \
    & = cos^2 x + sin^2 x \
    & = 1
$

*Step 3: Compute $u_1$.*

Using

$
  u_1' = -(y_2 g(x))/W
$

we obtain

$
  u_1' & = -(sin x csc x)/1 \
       & = -(sin x / sin x) \
       & = -1
$

Integrating,

$
  u_1 & = integral -1 dif x \
      & = -x
$

*Step 4: Compute $u_2$.*

Using

$
  u_2' = (y_1 g(x))/W
$

we obtain

$
  u_2' & = (cos x csc x)/1 \
       & = (cos x)/(sin x) \
       & = cot x
$

Integrating,

$
  u_2 & = integral cot x dif x \
      & = ln abs(sin x)
$

Since the domain is $0 < x < pi$, we know that
$sin x > 0$.

Therefore,

$
  u_2 = ln(sin x)
$

The integration constants can be omitted because they
produce terms already included in the homogeneous solution.

*Step 5: Construct the particular solution.*

Recall

$
  y_p = u_1 y_1 + u_2 y_2
$

Substituting,

$
  y_p & = (-x)(cos x) + ln(sin x) sin x \
      & = -x cos x + sin x ln(sin x)
$

*General solution:*

$
  y = C_1 cos x + C_2 sin x
  - x cos x + sin x ln(sin x)
$

= Patterns to Remember

== Polynomial Forcing

When $g(x)$ is a polynomial of degree $n$, choose a
general polynomial of the same degree.

For example,

$
  g(x) = 6 x^2 - 4 x + 1
$

requires

$
  y_p = A x^2 + B x + C
$

== Trigonometric Resonance

If the proposed particular solution overlaps with
the homogeneous solution, multiply the trial by $x$.

For example,

$
  y_p = x(A cos(2 x) + B sin(2 x))
$

== Repeated Characteristic Roots

If the characteristic root has multiplicity two,
multiply the usual trial by $x^2$.

For example,

$
  y_p = A x^2 e^(2 x)
$

== Mixed Forcing Terms

When the right-hand side contains multiple forcing terms,
construct a particular solution for each term.

Then add them together, applying resonance adjustments
only to the terms that overlap with $y_h$.

== Initial-Value Problems

First determine the general solution

$
  y = y_h + y_p
$

Then apply the initial conditions to determine the
unknown constants.

== Variation of Parameters

When undetermined coefficients is not appropriate,
use

$
  y_p = u_1 y_1 + u_2 y_2
$

where

$
  u_1' & = -(y_2 g(x))/W \
  u_2' & = (y_1 g(x))/W
$

= Final Review

The most important skill in undetermined coefficients
is choosing the correct form of the particular solution
before differentiating.

For variation of parameters, the key steps are computing
the Wronskian and evaluating the integrals for $u_1$
and $u_2$.

Both methods produce a general solution of the form

$
  y = y_h + y_p
$

