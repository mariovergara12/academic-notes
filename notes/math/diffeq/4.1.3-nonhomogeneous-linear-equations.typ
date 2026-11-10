#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.1.3 Nonhomogeneous Linear Equations",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.1.3 Nonhomogeneous Linear Equations

== Homogeneous plus particular

A nonhomogeneous linear equation has the form

$ L[y] = g(x), quad g(x) != 0. $

Let $y_p$ be *one particular solution* satisfying

$ L[y_p] = g(x), $

and let $y_h$ be the general solution of the associated homogeneous equation

$ L[y_h] = 0. $

Then

$ y = y_h + y_p $

is the *general solution of the nonhomogeneous equation*.

*Why?* By linearity,

$ L[y_h + y_p] = L[y_h] + L[y_p] = 0 + g(x) = g(x). $

Conversely, the difference of any two solutions of $L[y] = g(x)$ solves $L[z] = 0$.

Therefore, adding all homogeneous solutions to one particular solution gives every solution.

== Worked example

Solve

$ y'' + 4 y = 12 x. $

*Step 1: Associated homogeneous equation.*

Solve

$ y'' + 4 y = 0. $

Its characteristic equation is

$ r^2 + 4 = 0, $

with roots

$ r = plus.minus 2 i. $

Thus

$ y_h = C_1 cos(2 x) + C_2 sin(2 x). $

*Step 2: Particular solution.*

Try

$ y_p = A x + B. $

Then

$ y_p'' = 0, $

so

$ 4(A x + B) = 12 x. $

Matching coefficients gives

$ A = 3, quad B = 0. $

Hence

$ y_p = 3 x. $

*Step 3: Combine.*

$ y = C_1 cos(2 x) + C_2 sin(2 x) + 3 x. $

== Superposition for forcing terms

Suppose

$ L[y_(p,1)] = g_1(x) $

and

$ L[y_(p,2)] = g_2(x). $

Then, by linearity,

$ L[y_(p,1) + y_(p,2)] = g_1(x) + g_2(x). $

This allows you to solve a forcing function made of several terms *one term at a time* and add the particular solutions.

== Solution strategy

1. Solve $L[y] = 0$ to find $y_h$.
2. Find a *single* $y_p$ satisfying $L[y_p] = g(x)$.
3. Form $y = y_h + y_p$.
4. Apply any initial or boundary conditions to determine the constants.

Section 4.4 finds $y_p$ with *undetermined coefficients*; Section 4.6 uses *variation of parameters*.

*Source:* Part 2, pages 9–11. The example is reorganized into the standard $y_h + y_p$ structure.
