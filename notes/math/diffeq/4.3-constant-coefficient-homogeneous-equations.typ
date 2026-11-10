#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.3 Homogeneous Equations with Constant Coefficients",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.3 Homogeneous Linear Equations with Constant Coefficients

== Characteristic equation

Consider

$ a y'' + b y' + c y = 0, quad a != 0, $

where $a$, $b$, and $c$ are constants.

Try a solution

$ y = e^(r x). $

Since

$ y' = r e^(r x) $

and

$ y'' = r^2 e^(r x), $

substitution gives

$ (a r^2 + b r + c) e^(r x) = 0. $

Because $e^(r x) != 0$, the allowed values of $r$ satisfy the *characteristic equation*:

$ a r^2 + b r + c = 0. $

The quadratic formula gives

$ r = frac(-b plus.minus sqrt(b^2 - 4 a c), 2 a). $

The discriminant

$ Delta = b^2 - 4 a c $

tells you which solution form to use.

== Case 1: two distinct real roots ($Delta > 0$)

If the roots are $r_1 != r_2$, then

$ y = C_1 e^(r_1 x) + C_2 e^(r_2 x). $

*Example:* For

$ y'' - y = 0, $

the roots are

$ r = plus.minus 1, $

so

$ y = C_1 e^x + C_2 e^(-x). $

The Wronskian is nonzero, so these solutions are independent.

== Case 2: repeated real root ($Delta = 0$)

If $r$ is a double root, one solution is $e^(r x)$.

Reduction of order produces the second, independent solution

$ x e^(r x). $

Thus

$ y = (C_1 + C_2 x) e^(r x). $

*Example:* For

$ y'' - 4 y' + 4 y = 0, $

the characteristic equation is

$ (r - 2)^2 = 0, $

so

$ y = (C_1 + C_2 x) e^(2 x). $

== Case 3: complex conjugate roots ($Delta < 0$)

If

$ r = alpha plus.minus beta i, quad beta > 0, $

Euler's formula gives real solutions

$ e^(alpha x) cos(beta x) $

and

$ e^(alpha x) sin(beta x). $

Hence

$ y = e^(alpha x) (C_1 cos(beta x) + C_2 sin(beta x)). $

*Example:* For

$ y'' + 2 y' + 5 y = 0, $

the roots are

$ r = -1 plus.minus 2 i, $

so

$ y = e^(-x) (C_1 cos(2 x) + C_2 sin(2 x)). $

== Summary of the three cases

- *Distinct real roots:* $e^(r_1 x)$ and $e^(r_2 x)$.
- *Repeated real root:* $e^(r x)$ and $x e^(r x)$.
- *Complex roots:* $e^(alpha x) cos(beta x)$ and $e^(alpha x) sin(beta x)$.

For an $n$-th order constant-coefficient equation, a real root $r$ of multiplicity $m$ generates

$ e^(r x), quad x e^(r x), quad x^2 e^(r x), quad dots.c, quad x^(m - 1) e^(r x). $

For repeated complex roots, the corresponding sine and cosine solutions are likewise multiplied by successive powers of $x$.

*Source:* Part 2, pages 14–17. The three cases were collected into one decision guide.
