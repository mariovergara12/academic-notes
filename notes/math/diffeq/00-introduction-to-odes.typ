#import "/templates/academic.typ": *
#show: academic.with(
  title: "Introduction to Ordinary Differential Equations",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= Introduction to Ordinary Differential Equations

== What is an ODE?

An *ordinary differential equation* (ODE) relates an unknown function of *one independent variable* to one or more of its derivatives. A general $n$-th order ODE can be written as

$ F(x, y(x), y'(x), y''(x), dots, y^(n)(x)) = 0. $

- *Unknown function:* $y(x)$.
- *Independent variable:* $x$.
- *Order:* the highest derivative appearing in the equation.
- *Solution:* a differentiable function that makes the equation true on an interval.

For example, $y' = x^2$ is first order because the highest derivative is $y'$. Integrating gives

$ y = integral x^2 dif x = frac(x^3, 3) + C. $

*Check:* differentiating $x^3 / 3 + C$ gives $x^2$.

== Linear versus nonlinear equations

An $n$-th order ODE is *linear in the unknown function* if it can be written as

$ a_n(x) y^(n) + a_(n-1)(x) y^(n-1) + dots + a_1(x) y' + a_0(x) y = g(x). $

The coefficients $a_k(x)$ may depend on $x$, but not on $y$ or derivatives of $y$. The function $y$ and its derivatives appear only to the first power and are not multiplied together.

- *Linear:* $y'' + 2y' + y = x$.
- *Nonlinear:* $y' = y^2$, $y y' = x$, or $sin(y) + y' = 0$.

When $g(x) = 0$, a linear equation is called *homogeneous*; otherwise it is *nonhomogeneous*. This meaning of homogeneous is different from the degree-homogeneous first-order equations in Section 2.5.

== Initial-value problems (IVPs)

An *initial-value problem* combines an ODE with values of $y$ and possibly its derivatives at one point. For an $n$-th order equation, the typical conditions are

$ y(x_0) = b_0, quad y'(x_0) = b_1, quad dots, quad y^(n-1)(x_0) = b_(n-1). $

*Example:* Solve $y'' + y = 0$ with $y(0) = 1$ and $y'(0) = 0$.

The functions $cos x$ and $sin x$ solve the equation, so the general solution is

$ y = C_1 cos x + C_2 sin x. $

Applying $y(0) = 1$ gives $C_1 = 1$. Since $y' = -C_1 sin x + C_2 cos x$, applying $y'(0) = 0$ gives $C_2 = 0$. Therefore,

$ y(x) = cos x. $

== Boundary-value problems (BVPs)

A *boundary-value problem* imposes conditions at two or more points instead of specifying them all at one point. A typical second-order BVP is

$ y'' + y = 0, quad y(0) = 0, quad y(pi/2) = 1. $

Unlike standard linear IVPs under suitable continuity assumptions, a BVP can have no solution, one solution, or many solutions.

== Main approaches to solving ODEs

1. *Exact (analytic) methods:* obtain a formula for the solution, usually using integration or algebra.
2. *Approximation methods:* use local or global approximations when exact formulas are unavailable.
3. *Numerical methods:* compute approximate solution values using algorithms such as Euler's method or Runge--Kutta methods.

The original notes also emphasize *existence and uniqueness*: before solving, ask whether a solution is guaranteed to exist and whether it is the only one satisfying the stated conditions.

== Quick recognition checklist

- What is the *order* of the ODE?
- Is it *linear* or *nonlinear*?
- Is there a forcing term $g(x)$?
- Is the problem an *IVP*, *BVP*, or an equation without extra conditions?
- On which interval is the proposed solution valid?

*Source:* Part 1, pages 1--3. Corrections and extra clarifications were added for the linearity test and for IVP versus BVP behavior.
