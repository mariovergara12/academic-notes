#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.6 Method of Variation of Parameters",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.6 Method of Variation of Parameters

== Why this method is useful

*Variation of parameters* is a systematic way to find a particular solution of a second-order nonhomogeneous linear equation.

Unlike undetermined coefficients, it can work for more general forcing functions such as $sec x$, $ln x$, and rational expressions, provided the required integrals can be evaluated.

First put the equation into *standard form*:

$ y'' + P(x) y' + Q(x) y = g(x). $

Suppose $y_1$ and $y_2$ are linearly independent solutions of the associated homogeneous equation.

== Deriving the formulas

The homogeneous solution is

$ y_h = C_1 y_1 + C_2 y_2. $

Instead of constants $C_1$ and $C_2$, allow the coefficients to vary with $x$ and seek

$ y_p = u_1(x) y_1(x) + u_2(x) y_2(x). $

Choose the simplifying condition

$ u_1' y_1 + u_2' y_2 = 0. $

Differentiating and substituting into the differential equation yields a second condition:

$ u_1' y_1' + u_2' y_2' = g(x). $

Solve these two linear equations using the Wronskian

$ W(y_1, y_2) = y_1 y_2' - y_1' y_2. $

Because $y_1$ and $y_2$ are independent solutions of a regular equation, $W != 0$ on the interval.

The key formulas are

$ u_1' = -frac(y_2 g(x), W(y_1, y_2)), $

$ u_2' = frac(y_1 g(x), W(y_1, y_2)). $

Then integrate to find $u_1$ and $u_2$ and substitute into

$ y_p = u_1 y_1 + u_2 y_2. $

Integration constants can be taken as $0$ in $u_1$ and $u_2$ because their effects are already included in $y_h$.

*Important:* If the original equation is

$ a(x) y'' + b(x) y' + c(x) y = f(x), $

the function used above is

$ g(x) = frac(f(x), a(x)), $

not the unnormalized $f(x)$.

== Worked example 1: $y'' + y = sec x$

Find the solution on $(-pi / 2, pi / 2)$.

The associated homogeneous equation has characteristic roots $plus.minus i$, so

$ y_1 = cos x, quad y_2 = sin x, $

$ y_h = C_1 cos x + C_2 sin x. $

Compute the Wronskian:

$ W = cos x cos x - (-sin x) sin x = cos^2 x + sin^2 x = 1. $

The variation formulas become

$ u_1' = -sin x sec x = -tan x, $

$ u_2' = cos x sec x = 1. $

Integrating on the stated interval, where $cos x > 0$,

$ u_1 = ln(cos x), quad u_2 = x. $

Thus

$ y_p = cos x ln(cos x) + x sin x, $

and the complete solution is

$ y = C_1 cos x + C_2 sin x + cos x ln(cos x) + x sin x. $

== Worked example 2: $y'' - 4 y' + 4 y = frac(e^(2 x), x^2)$

Assume $x > 0$.

The homogeneous characteristic equation

$ (r - 2)^2 = 0 $

gives

$ y_1 = e^(2 x), quad y_2 = x e^(2 x). $

Compute their derivatives:

$ y_1' = 2 e^(2 x), $

$ y_2' = (1 + 2 x) e^(2 x). $

The Wronskian is

$ W = e^(2 x) (1 + 2 x) e^(2 x) - 2 e^(2 x) x e^(2 x) = e^(4 x). $

Since

$ g(x) = frac(e^(2 x), x^2), $

we obtain

$ u_1' = -frac(x e^(2 x) e^(2 x) / x^2, e^(4 x)) = -frac(1, x), $

$ u_2' = frac(e^(2 x) e^(2 x) / x^2, e^(4 x)) = frac(1, x^2). $

Integrating yields

$ u_1 = -ln x, quad u_2 = -frac(1, x). $

Therefore,

$ y_p = (-ln x) e^(2 x) - frac(1, x) (x e^(2 x)). $

Simplifying,

$ y_p = -e^(2 x) ln x - e^(2 x). $

The final $-e^(2 x)$ term is itself a homogeneous solution and can be absorbed into $C_1$.

A cleaner general solution is

$ y = e^(2 x) (C_1 + C_2 x - ln x), quad x > 0. $

== Worked example 3: completed IVP from the last scan

Solve

$ y'' + 2 y' + y = e^(-x) ln x, $

with

$ y(1) = 0, quad y'(1) = 0, $

on $x > 0$.

*Step 1: Homogeneous equation.*

The characteristic equation is

$ (r + 1)^2 = 0. $

Thus

$ y_1 = e^(-x), quad y_2 = x e^(-x), $

$ y_h = (C_1 + C_2 x) e^(-x). $

*Step 2: Wronskian.*

Since

$ y_1' = -e^(-x) $

and

$ y_2' = (1 - x) e^(-x), $

we obtain

$ W = e^(-x) (1 - x) e^(-x) - (-e^(-x)) x e^(-x) = e^(-2 x). $

*Step 3: Find $u_1'$ and $u_2'$.*

With

$ g(x) = e^(-x) ln x, $

the variation formulas give

$ u_1' = -frac(x e^(-x) e^(-x) ln x, e^(-2 x)) = -x ln x, $

$ u_2' = frac(e^(-x) e^(-x) ln x, e^(-2 x)) = ln x. $

*Step 4: Integrate.*

Integration by parts gives

$ u_1 = -integral x ln x dif x = -frac(x^2, 2) ln x + frac(x^2, 4), $

$ u_2 = integral ln x dif x = x ln x - x. $

The last integral has a *minus $x$*, which is important.

*Step 5: Build $y_p$.*

$ y_p = u_1 e^(-x) + u_2 x e^(-x). $

Substituting and simplifying,

$ y_p = e^(-x) (frac(x^2, 2) ln x - frac(3 x^2, 4)). $

Therefore,

$ y = e^(-x) (C_1 + C_2 x + frac(x^2, 2) ln x - frac(3 x^2, 4)). $

*Step 6: Apply the initial conditions.*

Let

$ F(x) = C_1 + C_2 x + frac(x^2, 2) ln x - frac(3 x^2, 4), $

so that

$ y = e^(-x) F $

and

$ y' = e^(-x) (F' - F). $

From $y(1) = 0$, we get

$ C_1 + C_2 - frac(3, 4) = 0. $

Also,

$ F'(x) = C_2 + x ln x - x. $

Since $F(1) = 0$, the condition $y'(1) = 0$ gives $F'(1) = 0$.

Hence

$ C_2 = 1, quad C_1 = -frac(1, 4). $

The unique solution satisfying both conditions is

$ y = e^(-x) (-frac(1, 4) + x + frac(x^2, 2) ln x - frac(3 x^2, 4)), quad x > 0. $

*Source note:* The handwriting on Part 3, page 5 stops during the integrals. All later steps in this worked example are completed here. The antiderivative of $ln x$ has been corrected to $x ln x - x$.

== Fast exam checklist

1. Divide by the coefficient of $y''$.
2. Solve the homogeneous equation and identify $y_1$ and $y_2$.
3. Compute and simplify $W = y_1 y_2' - y_1' y_2$.
4. Use $u_1' = -y_2 g / W$ and $u_2' = y_1 g / W$.
5. Integrate, form $y_p = u_1 y_1 + u_2 y_2$, and simplify.
6. Add $y_h$, absorb any redundant homogeneous terms, and apply the initial conditions.

*Common mistakes:*

- Using the wrong Wronskian sign.
- Forgetting to convert to standard form.
- Losing a negative sign in $u_1'$.
- Treating $u_1$ and $u_2$ as constants instead of functions.
- Forgetting the constant of integration when solving the full equation.

*Source:* Part 2, pages 23–24, continuing into Part 3, pages 1–5. This entire section is presented as one continuous set of notes.
