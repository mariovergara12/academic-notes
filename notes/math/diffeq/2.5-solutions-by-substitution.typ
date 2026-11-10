#import "/templates/academic.typ": *

#show: academic.with(
  title: "2.5 Solutions by Substitution",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 2.5 Solutions by Substitution

== Why substitution works

Some nonlinear first-order equations become separable or linear after changing variables. The notes focus on first-order equations whose coefficients are *homogeneous functions of the same degree*.

A function $F(x, y)$ is homogeneous of degree $k$ if

$ F(t x, t y) = t^k F(x, y) $

for all scaling factors for which the expression is defined.

For a differential equation

$ M(x, y) dif x + N(x, y) dif y = 0, $

if $M$ and $N$ are homogeneous of the *same degree*, use

$ y = u x, quad u = frac(y, x), quad dif y = u dif x + x dif u. $

The transformed equation often separates into an equation in $u$ and $x$.

== Step-by-step method

1. Identify $M$ and $N$ and confirm the same scaling degree.
2. Substitute $y = u x$ and $dif y = u dif x + x dif u$.
3. Simplify and cancel common powers of $x$ where $x != 0$.
4. Separate variables and integrate.
5. Substitute $u = y / x$ back into the result.
6. *Check any special constant-ratio solutions* that may have been lost by dividing by factors such as $u + 1$.

== Worked example from the notes

Solve

$ (x^2 + y^2) dif x + (x^2 - x y) dif y = 0. $

The coefficient functions satisfy

$ M(t x, t y) = t^2 M(x, y), quad N(t x, t y) = t^2 N(x, y), $

so both have degree $2$.

Set

$ y = u x. $

Then

$ (x^2 + u^2 x^2) dif x + (x^2 - u x^2)(u dif x + x dif u) = 0. $

Expand, collect like terms, and factor:

$ x^2(1 + u) dif x + x^3(1 - u) dif u = 0. $

For $x != 0$ and $u != -1$, separate variables:

$ frac(dif x, x) = frac(u - 1, u + 1) dif u. $

Use the identity

$ frac(u - 1, u + 1) = 1 - frac(2, u + 1). $

Therefore,

$ integral frac(1, x) dif x = integral (1 - frac(2, u + 1)) dif u. $

After integration,

$ ln abs(x) = u - 2 ln abs(u + 1) + C. $

Substitute back $u = y / x$:

$ ln abs(x) = frac(y, x) - 2 ln abs(frac(y, x) + 1) + C. $

This is an *implicit solution family*, valid on suitable intervals with $x != 0$ and $y != -x$.

== Important special solution

The separation divided by $u + 1$, so check $u = -1$ separately.

This means

$ y = -x. $

In the original equation, when $y = -x$ and $dif y = -dif x$,

$ (x^2 + x^2) dif x + (x^2 + x^2)(-dif x) = 0. $

Therefore, *$y = -x$ is also a valid solution*.

It must be listed separately because division by $u + 1$ removed it from the integration calculation.

== Do not confuse two meanings of homogeneous

- *This section:* $M(t x, t y) = t^k M(x, y)$ and $N(t x, t y) = t^k N(x, y)$.
- *Linear ODEs in Chapter 4:* the right-hand side is zero, $L[y] = 0$.

These are different definitions used in different settings.

*Source:* Part 1, pages 18–21. The notes' derivation has been preserved, and the missing special solution $y = -x$ has been added.
