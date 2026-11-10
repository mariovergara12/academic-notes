#import "/templates/academic.typ": *
#show: academic.with(
  title: "4.1.1 Initial-Value and Boundary-Value Problems",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.1.1 Initial-Value and Boundary-Value Problems

== General $n$-th order linear equation

An $n$-th order linear equation has the form

$ a_n(x)y^(n)+a_(n-1)(x)y^(n-1)+dots+a_1(x)y'+a_0(x)y=g(x). $

A standard *initial-value problem* includes $n$ conditions at a single point $x_0$:

$ y(x_0)=b_0, quad y'(x_0)=b_1, quad dots, quad y^(n-1)(x_0)=b_(n-1). $

The problem is to find a function that satisfies both the ODE and all the conditions.

== Existence and uniqueness theorem

Suppose the coefficient functions $a_0,a_1,dots,a_n$ and the forcing function $g$ are continuous on an interval $I$, and

$ a_n(x) != 0 quad "for every" x in I. $

If $x_0$ is in $I$, then an $n$-th order linear IVP with prescribed values $y(x_0),y'(x_0),dots,y^(n-1)(x_0)$ has exactly one solution on $I$.

*Why the leading coefficient matters:* dividing by $a_n(x)$ puts the equation into a standard form. If $a_n$ vanishes, this theorem does not apply across that point, although a solution might still exist for particular data.

== Example: conditions without solving the equation

Consider

$ y''' + 6y'' - 7y' + 8y = 0, $

with initial conditions $y(0)=0$, $y'(0)=1$, and $y''(0)=2$. All coefficients are constant, and the coefficient of $y'''$ is $1 != 0$ on the real line. The theorem guarantees a *unique global solution* without requiring us to compute its explicit formula.

== Boundary-value problems

A *boundary-value problem* (BVP) gives constraints at different locations, such as

$ y''+y=0, quad y(0)=0, quad y(pi/2)=1. $

IVP uniqueness theorems do not automatically give uniqueness for BVPs. Boundary conditions may lead to zero, one, or multiple solutions.

== Checklist before solving an IVP

1. Find the order $n$.
2. Identify $a_n(x)$ and the forcing $g(x)$.
3. Find an interval where all coefficients are continuous and $a_n != 0$.
4. Make sure the initial point $x_0$ lies inside that interval.
5. Count the required initial conditions ($n$ for an $n$-th order equation).

*Source:* Part 1, pages 22--24. Section 4.1 continues in Part 2; the related homogeneous and nonhomogeneous material is in separate files.
