#import "/templates/academic.typ": *
#show: academic.with(
  title: "2.1 Solution Curves and Direction Fields",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 2.1 Solution Curves Without a Solution

== 2.1.1 Direction fields

Consider a first-order ODE in the form

$ y' = f(x, y). $

At any point $(x_0, y_0)$ where $f$ is defined, the derivative determines the *slope of the tangent* to a solution curve:

$ m = y'(x_0) = f(x_0, y_0). $

A *direction field* (or *slope field*) draws a short line segment with this slope at each point on a grid. Even without an explicit formula for $y(x)$, the segments show the qualitative behavior of solutions.

== How to sketch a direction field

1. Pick points $(x_0,y_0)$ across the plane.
2. Calculate $f(x_0,y_0)$.
3. Draw a short segment of slope $f(x_0,y_0)$ at each selected point.
4. Sketch solution curves tangent to the segments, respecting any initial condition.

*Interpretation:* a positive slope means the curve is rising as $x$ increases; a negative slope means it is falling; slope $0$ indicates a horizontal tangent.

== Isoclines

An *isocline* is a curve along which the slope field has the same fixed value $c$:

$ f(x,y) = c. $

Find an isocline by solving this equation for the points $(x,y)$. Then draw short segments of slope $c$ along it. Isoclines can simplify a direction-field sketch.

== Worked example: concentric circular solution curves

Consider the equation from the notes:

$ y' = -frac(x, y), quad y != 0. $

Separate the variables:

$ y dif y = -x dif x. $

Integrate:

$ frac(y^2, 2) = -frac(x^2, 2) + C. $

Rearranging gives

$ x^2 + y^2 = K. $

These level curves are circles centered at the origin. For the ODE $y'=-x/y$, only arcs on which $y != 0$ are valid graphs of solutions. When $x=0$ and $y != 0$, the slope is $0$. At $y=0$, the ODE is undefined, so we cannot draw a finite slope segment there.

== Local existence and uniqueness

A standard first-order theorem says: if $f(x,y)$ and its partial derivative with respect to $y$ are continuous in a rectangle around $(x_0,y_0)$, the IVP

$ y' = f(x,y), quad y(x_0) = y_0 $

has exactly one local solution through that point.

*Application to the example:* $f(x,y)=-x/y$ and $partial f / partial y = x/y^2$ are continuous when $y != 0$, so a unique local solution exists through each point off the $x$-axis.

== What to remember

- Direction fields describe solutions *geometrically*, without first solving the ODE.
- An isocline groups points with equal slope.
- Singular points where $f$ is undefined require separate care.
- The equation $x^2+y^2=K$ describes a family of curves; an individual solution $y(x)$ usually corresponds to a suitable arc.

*Source:* Part 1, pages 10--12. The distinction between a full implicit circle and a valid graph solution was made explicit.
