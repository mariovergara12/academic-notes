#import "/templates/academic.typ": *

#show: academic.with(
  title: "2.4 Exact Equations",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 2.4 Exact Equations

== Differential form

A first-order ODE can be expressed as

$ M(x, y) dif x + N(x, y) dif y = 0. $

It is called *exact* if there is a potential function $F(x, y)$ such that

$ frac(partial F, partial x) = M(x, y), quad frac(partial F, partial y) = N(x, y). $

Then

$ dif F = M dif x + N dif y = 0, $

so the implicit general solution is

$ F(x, y) = C. $

== Exactness test

If $M$ and $N$ have continuous first partial derivatives on a suitable simply connected region, a practical test is

$ frac(partial M, partial y) = frac(partial N, partial x). $

*Be careful:* The test uses *partial*, not ordinary, derivatives. If the equality fails, the equation is not exact on that region in the present form.

== Solving an exact equation

1. Identify $M(x, y)$ and $N(x, y)$.
2. Check $M_y = N_x$.
3. Integrate $M$ with respect to $x$ while treating $y$ as constant:

  $ F(x, y) = integral M(x, y) dif x + h(y). $

4. Differentiate this expression with respect to $y$ and set it equal to $N$.
5. Solve for $h'(y)$, integrate, and write $F(x, y) = C$.

*Why $h(y)$?* Integrating with respect to $x$ permits an arbitrary function of $y$, not merely a numerical constant.

== Worked example: $(2 x - 1) dif x + (3 y + 7) dif y = 0$

Set

$ M(x, y) = 2 x - 1 $

and

$ N(x, y) = 3 y + 7. $

Then

$ M_y = 0, quad N_x = 0. $

Because the derivatives match, the equation is exact.

Integrate $M$ with respect to $x$:

$ F(x, y) = integral (2 x - 1) dif x = x^2 - x + h(y). $

Differentiate with respect to $y$:

$ F_y = h'(y) = 3 y + 7. $

Thus

$ h(y) = frac(3, 2) y^2 + 7 y. $

The implicit general solution is

$ x^2 - x + frac(3, 2) y^2 + 7 y = C. $

== Short motivating example

For

$ y dif x + x dif y = 0, $

notice the product rule:

$ dif(x y) = y dif x + x dif y. $

Hence

$ x y = C, $

or

$ y = frac(C, x) $

when $x != 0$.

== What to check

- An exact equation produces an *implicit* solution $F(x, y) = C$; an explicit $y(x)$ formula is optional.
- A potential function is only guaranteed locally or on appropriate regions; region assumptions matter.
- When checking your result, differentiate $F(x, y) = C$ to recover $M dif x + N dif y = 0$.

*Source:* Part 1, pages 13–17. The worked example was continued across pages 16–17; the function-of-$y$ step has been clarified.
