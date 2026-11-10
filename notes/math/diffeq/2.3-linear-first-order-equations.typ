#import "/templates/academic.typ": *

#show: academic.with(
  title: "2.3 Linear First-Order Equations",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 2.3 Linear First-Order Equations

== Definition and standard form

A first-order equation is *linear* if it can be written as

$ a_1(x) y' + a_0(x) y = g(x). $

Where $a_1(x) != 0$, divide through by $a_1(x)$ to obtain *standard form*:

$ y' + P(x) y = f(x), $

where

$ P(x) = frac(a_0(x), a_1(x)) $

and

$ f(x) = frac(g(x), a_1(x)). $

*Important:* Convert to standard form *before* finding the integrating factor. The coefficient of $y'$ must be exactly $1$.

== Case A: homogeneous linear equation

If $f(x) = 0$, the equation is

$ y' + P(x) y = 0. $

For a nonzero solution, separate the variables:

$ frac(d y, y) = -P(x) dif x. $

Integrating gives

$ ln abs(y) = -integral P(x) dif x + C, $

and therefore

$ y = C e^(-integral P(x) dif x). $

The choice $C = 0$ includes the zero solution, which the separation step temporarily excluded.

== Case B: nonhomogeneous linear equation

For a general forcing term $f(x)$, define the *integrating factor*

$ mu(x) = e^(integral P(x) dif x). $

Multiply the whole ODE by $mu(x)$:

$ mu y' + mu P y = mu f. $

Because

$ mu' = P mu, $

the left-hand side is a product derivative:

$ (mu y)' = mu f. $

Integrate and solve for $y$:

$ mu y = integral mu(x) f(x) dif x + C, $

$ y = frac(1, mu(x)) (integral mu(x) f(x) dif x + C). $

== Worked example 1: $y' + 2 y = 0$

Here $P(x) = 2$. The homogeneous formula gives

$ y = C e^(-integral 2 dif x) = C e^(-2 x). $

*Check:*

$ y' + 2 y = -2 C e^(-2 x) + 2 C e^(-2 x) = 0. $

== Worked example 2: $y' + y = e^(3 x)$

The integrating factor is

$ mu = e^x. $

Multiplying gives

$ e^x y' + e^x y = e^(4 x), $

so

$ (e^x y)' = e^(4 x). $

Integrate:

$ e^x y = frac(e^(4 x), 4) + C. $

Thus the general solution is

$ y = frac(e^(3 x), 4) + C e^(-x). $

== Worked example 3: $y' - 5 y = x$, $y(0) = 3$

This is already in standard form, with

$ P(x) = -5, quad f(x) = x. $

The integrating factor is

$ mu(x) = e^(-5 x). $

Multiplying through gives

$ (e^(-5 x) y)' = x e^(-5 x). $

Evaluate by integration by parts:

$ integral x e^(-5 x) dif x = -frac(x, 5) e^(-5 x) - frac(1, 25) e^(-5 x) + C. $

Therefore,

$ y = -frac(x, 5) - frac(1, 25) + C e^(5 x). $

Apply the initial condition:

$ 3 = -frac(1, 25) + C quad => quad C = frac(76, 25). $

The solution is

$ y(x) = -frac(x, 5) - frac(1, 25) + frac(76, 25) e^(5 x). $

== Fast exam workflow

1. Rewrite the ODE as $y' + P(x) y = f(x)$.
2. Compute $mu(x) = e^(integral P(x) dif x)$.
3. Multiply *every term* by $mu$.
4. Replace the left-hand side with $(mu y)'$.
5. Integrate, divide by $mu$, and apply initial conditions.
6. Differentiate the answer to verify it satisfies the original equation.

*Common mistakes:*

- Using $e^(-integral P(x) dif x)$ instead of $e^(integral P(x) dif x)$ for the integrating factor.
- Neglecting to multiply the right-hand side by $mu$.
- Forgetting the constant of integration.
- Forgetting to convert the equation into standard form first.

*Source:* Part 1, pages 4–9. The third example continues across pages 8–9 and is assembled into one calculation here.
