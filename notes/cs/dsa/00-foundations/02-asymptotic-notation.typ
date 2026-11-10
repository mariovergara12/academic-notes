#import "/templates/academic.typ": *
#show: academic.with(
  title: "Asymptotic Notation and Growth",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 4, 8–10, 14–15
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Why asymptotic notation matters
It describes how cost scales as input size $n$ grows, ignoring fixed constant factors and lower-order terms. The notebook compares curves and proves bounds using constants and limits.

== Definitions
For eventually nonnegative functions $f,g$:
- $f(n)=O(g(n))$ means $f(n) <= c g(n)$ for constants $c>0$ and all sufficiently large $n$ (*asymptotic upper bound*).
- $f(n)=Omega(g(n))$ means $f(n) >= c g(n)$ eventually (*lower bound*).
- $f(n)=Theta(g(n))$ means both upper and lower bounds hold (*tight bound*).

== Worked examples
$5n^2+20n+15=Theta(n^2)$, because the $n^2$ term dominates as $n$ grows. For $n>=1$, one can bound the expression above by $40n^2$ and below by $5n^2$.

$200n=O(n^2)$: choose $c=200$ and $n_0=1$. But $n^2$ is *not* $O(n)$, because $n^2/n=n$ grows without bound.

The polynomial rule: a polynomial with nonzero leading coefficient and degree $d$ is $Theta(n^d)$.

== Common growth ordering
$1$, $log log n$, $log n$, $(log n)^2$, $sqrt(n)$, $n$, $n log n$, $n^2$, $n^3$, $2^n$, $n!$ (eventually increasing).

== Limits as proof tools
For positive $g$, if $lim_(n -> infinity) f(n)/g(n)=L$ with $0<L<infinity$, then $f=Theta(g)$. A limit of $0$ implies $f=o(g)$; a limit of $infinity$ implies $g=o(f)$.

== Useful identity: factorial and logarithms
$log(n!)=sum_(i=1)^n log i=Theta(n log n)$.
For an upper bound, $log(n!) <= n log n$. For a lower bound, the largest $n/2$ terms each contribute at least $log(n/2)$, so $log(n!) >= (n/2)log(n/2)=Omega(n log n)$.

*Class-note focus:* When asked for a tight runtime, give $Theta$, not just a valid but loose $O$ bound.
