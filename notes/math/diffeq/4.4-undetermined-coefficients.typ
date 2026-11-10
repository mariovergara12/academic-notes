#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.4 Undetermined Coefficients",
  course: "Differential Equations",
  semester: "Fall 2026",
)

= 4.4 Undetermined Coefficients

== Purpose

The *method of undetermined coefficients* finds a particular solution $y_p$ of a linear nonhomogeneous equation with *constant coefficients*, when the forcing term has an appropriate form (polynomials, exponentials, sines, cosines, and finite sums or products of these).

For

$ L[y] = g(x), $

first solve the associated homogeneous equation to find $y_h$. Then guess a family of possible $y_p$ functions containing unknown constants, substitute, and solve for those constants.

== Common guesses

- $g(x) = k$ (nonzero constant): try $y_p = A$.
- $g(x)$ a polynomial of degree $n$: try a general polynomial $A_n x^n + dots.c + A_0$.
- $g(x) = e^(a x)$: try $y_p = A e^(a x)$.
- $g(x) = sin(b x)$ or $cos(b x)$: try $y_p = A cos(b x) + B sin(b x)$.
- $g(x) = e^(a x) (P_n(x) cos(b x) + Q_m(x) sin(b x))$: try the corresponding exponential times *both* polynomial-trigonometric components, using polynomials of degree at most $max(n, m)$ for both sine and cosine.

For a sum of forcing terms, find a particular solution for each and add them (superposition).

== Resonance: what if the guess duplicates $y_h$?

If a term in the proposed $y_p$ is already part of the homogeneous solution, multiply the *entire trial family* by $x^s$, where $s$ is the smallest nonnegative integer that removes the overlap. For a characteristic root of multiplicity $s$, this is exactly the required exponent for the corresponding exponential-trigonometric trial family.

*Example:* $y'' - y = e^x$.

Since $e^x$ appears in

$ y_h = C_1 e^x + C_2 e^(-x), $

use

$ y_p = A x e^x, $

not $A e^x$.

Then

$ y_p'' - y_p = 2 A e^x = e^x, $

so

$ A = frac(1, 2) $

and a valid particular solution is

$ y_p = frac(x e^x, 2). $

== Worked example 1: $y'' + 3 y' + 2 y = 6$

The characteristic equation is

$ (r + 1)(r + 2) = 0, $

so

$ y_h = C_1 e^(-x) + C_2 e^(-2 x). $

Try the constant

$ y_p = A. $

Substituting gives

$ 2 A = 6, $

so $A = 3$.

The general solution is

$ y = C_1 e^(-x) + C_2 e^(-2 x) + 3. $

== Worked example 2: $y'' + 4 y' - 2 y = 2 x^2 - 3 x + 6$

Because the right-hand side is quadratic, try

$ y_p = A x^2 + B x + C. $

Then

$ y_p' = 2 A x + B $

and

$ y_p'' = 2 A. $

Substitution gives

$ 2 A + 4(2 A x + B) - 2(A x^2 + B x + C) = 2 x^2 - 3 x + 6. $

Matching coefficients:

- $x^2$: $-2 A = 2$, so $A = -1$.
- $x$: $8 A - 2 B = -3$, so $B = -frac(5, 2)$.
- Constant: $2 A + 4 B - 2 C = 6$, so $C = -9$.

Therefore,

$ y_p = -x^2 - frac(5, 2) x - 9. $

The homogeneous equation has characteristic roots

$ r = -2 plus.minus sqrt(6). $

Thus the complete solution is

$ y = C_1 e^((-2 + sqrt(6)) x) + C_2 e^((-2 - sqrt(6)) x) - x^2 - frac(5, 2) x - 9. $

== Worked example 3: $4 y'' - 4 y' - 3 y = cos(2 x)$

A trigonometric forcing term requires *both* sine and cosine in the trial:

$ y_p = A cos(2 x) + B sin(2 x). $

Then

$ y_p' = -2 A sin(2 x) + 2 B cos(2 x), $

$ y_p'' = -4 A cos(2 x) - 4 B sin(2 x). $

Substitution into

$ 4 y'' - 4 y' - 3 y = cos(2 x) $

gives

$ (-19 A - 8 B) cos(2 x) + (8 A - 19 B) sin(2 x) = cos(2 x). $

Hence

$ -19 A - 8 B = 1 $

and

$ 8 A - 19 B = 0. $

Solving gives

$ A = -frac(19, 425), quad B = -frac(8, 425). $

A particular solution is

$ y_p = -frac(19, 425) cos(2 x) - frac(8, 425) sin(2 x). $

*Correction:* One handwritten line lists $B cos(2 x)$ instead of $B sin(2 x)$; the subsequent derivatives and final expression show that the sine term is intended. It is written consistently here.

== Worked example 4: $y'' - y = 6 e^(2 x) + 5 sin x$

The homogeneous roots are

$ r = plus.minus 1, $

so

$ y_h = C_1 e^x + C_2 e^(-x). $

Neither $e^(2 x)$ nor the sine/cosine pair duplicates $y_h$.

Try

$ y_p = A e^(2 x) + B cos x + C sin x. $

Then

$ y_p'' - y_p = 3 A e^(2 x) - 2 B cos x - 2 C sin x. $

Matching $6 e^(2 x) + 5 sin x$ gives

$ 3 A = 6, $

$ -2 B = 0, $

$ -2 C = 5. $

Therefore,

$ y_p = 2 e^(2 x) - frac(5, 2) sin x, $

and

$ y = C_1 e^x + C_2 e^(-x) + 2 e^(2 x) - frac(5, 2) sin x. $

== Exam checklist

1. Solve the characteristic equation for $y_h$.
2. Select the appropriate form for $y_p$.
3. Check for overlap with $y_h$; if needed, multiply by $x^s$.
4. Differentiate and substitute the *entire* trial family.
5. Equate coefficients of independent terms and solve the algebraic system.
6. Add $y_h + y_p$ and verify.

*Limitation:* Undetermined coefficients does not generally handle forcing functions such as $ln x$, $tan x$, or $sec x$; see Section 4.6.

*Source:* Part 2, pages 18–22. The final example starts at the end of page 22; no continuation from Part 3 is needed for this section.
