#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.1.2 Homogeneous Linear Equations",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.1.2 Homogeneous Linear Equations

== Homogeneous equation and differential operator

For an $n$-th order linear differential equation, write

$ L[y] = a_n(x) y^((n)) + dots.c + a_1(x) y' + a_0(x) y. $

The notation $D$ represents differentiation:

$ D y = y', quad D^2 y = y'', quad D^n y = y^((n)). $

Thus an operator can be represented as

$ L = a_n(x) D^n + dots.c + a_1(x) D + a_0(x). $

- A *homogeneous* linear equation is $L[y] = 0$.
- A *nonhomogeneous* linear equation is $L[y] = g(x)$ with $g$ not identically zero.

The operator is linear, meaning

$ L[c_1 y_1 + c_2 y_2] = c_1 L[y_1] + c_2 L[y_2]. $

== Superposition principle

If $y_1, dots.c, y_k$ solve the *same homogeneous* linear equation $L[y] = 0$, then every linear combination

$ y = c_1 y_1 + dots.c + c_k y_k $

also solves the equation.

*Proof:* By linearity,

$ L[y] = c_1 L[y_1] + dots.c + c_k L[y_k] = 0. $

This principle does *not* let us add arbitrary solutions to two different forcing terms and claim the result solves one of the original equations; see Section 4.1.3 for the correct forcing-term rule.

== Linear independence

Functions $f_1, dots.c, f_n$ are *linearly dependent* on an interval $I$ if there are constants $c_1, dots.c, c_n$, not all zero, such that

$ c_1 f_1(x) + dots.c + c_n f_n(x) = 0 $

for every $x$ in $I$.

If the only such constants are all zero, the functions are *linearly independent*.

*Example from the notes:* On an interval where the expressions exist,

$ cos^2 x + sin^2 x - sec^2 x + tan^2 x = 0. $

The functions $cos^2 x$, $sin^2 x$, $sec^2 x$, and $tan^2 x$ are therefore linearly dependent.

== The Wronskian

For two functions,

$ W(y_1, y_2) = det(mat(y_1, y_2; y_1', y_2')) = y_1 y_2' - y_1' y_2. $

For $n$ functions, the Wronskian is the determinant whose rows contain the functions, their first derivatives, and so on through derivative $n - 1$.

For an $n$-th order homogeneous linear ODE with continuous coefficients and nonzero leading coefficient on $I$, *$n$ solution functions form a fundamental set exactly when their Wronskian is nonzero at one (equivalently, every) point of $I$*.

*Precision:* For completely arbitrary differentiable functions, a zero Wronskian alone need not imply dependence. The stronger equivalence above uses the fact that the functions all solve the same regular linear ODE.

== Fundamental set of solutions

A set $y_1, dots.c, y_n$ is a *fundamental set* if its members are $n$ linearly independent solutions of the same $n$-th order homogeneous linear ODE on an interval.

Once a fundamental set is known, the general homogeneous solution is

$ y_h = c_1 y_1 + dots.c + c_n y_n. $

*Example:* For $y'' - y = 0$, use

$ y_1 = e^x, quad y_2 = e^(-x). $

Their Wronskian is

$ W = e^x (-e^(-x)) - e^x e^(-x) = -2 != 0. $

So they form a fundamental set, and

$ y_h = C_1 e^x + C_2 e^(-x). $

== What to remember

- *Superposition* produces new homogeneous solutions.
- *Linear independence* ensures that the solutions contribute genuinely different directions.
- The *Wronskian* tests independence for solution sets of a regular linear ODE.
- An $n$-th order homogeneous linear ODE needs $n$ independent solutions to express its general solution.

*Source:* Part 1, page 24, and Part 2, pages 1–9. The section starts at the end of Part 1 and continues into Part 2.

