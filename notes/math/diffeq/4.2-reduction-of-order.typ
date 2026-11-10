#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.2 Reduction of Order",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.2 Reduction of Order

== Goal

Suppose a second-order homogeneous linear equation

$ y'' + P(x) y' + Q(x) y = 0 $

has one known nonzero solution $y_1(x)$.

*Reduction of order* finds a second solution $y_2(x)$ that is linearly independent from $y_1$.

== Main substitution

Assume

$ y_2(x) = u(x) y_1(x), $

where $u(x)$ is an *unknown function*, not a constant.

Using the product rule,

$ y_2' = u' y_1 + u y_1', $

$ y_2'' = u'' y_1 + 2 u' y_1' + u y_1''. $

Substitute into the original ODE:

$ (u'' y_1 + 2 u' y_1' + u y_1'') + P(u' y_1 + u y_1') + Q u y_1 = 0. $

The terms with $u$ cancel because $y_1$ already satisfies the homogeneous equation.

The remaining equation is

$ y_1 u'' + (2 y_1' + P y_1) u' = 0. $

This is first order in $v = u'$.

== Useful formula

On an interval where $y_1(x) != 0$, the second solution can be expressed as

$ y_2 = y_1 integral frac(e^(-integral P(x) dif x), y_1^2) dif x. $

A nonzero multiple or the addition of a multiple of $y_1$ does not change the span of the fundamental set.

== Worked example: given $y_1 = e^x$ for $y'' - y = 0$

Let

$ y_2 = u e^x. $

Then

$ y_2' = e^x (u' + u), $

$ y_2'' = e^x (u'' + 2 u' + u). $

Substitution into

$ y_2'' - y_2 = 0 $

gives

$ e^x (u'' + 2 u') = 0, $

hence

$ u'' + 2 u' = 0. $

Let $v = u'$; then

$ v' + 2 v = 0, quad v = C e^(-2 x). $

Integrating once more,

$ u = K_1 + K_2 e^(-2 x). $

The $K_1 e^x$ term reproduces the known solution.

Choosing the new term gives

$ y_2 = e^(-x). $

Therefore,

$ y = C_1 e^x + C_2 e^(-x). $

== When to use it

- The equation is *second-order, linear, and homogeneous*.
- One nonzero solution $y_1$ is already known.
- You need another independent solution to form a general solution.

*Source:* Part 2, pages 12–13. The derivation and standard reduction-of-order formula have been made explicit.
