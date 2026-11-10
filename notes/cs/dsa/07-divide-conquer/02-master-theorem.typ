#import "/templates/academic.typ": *
#show: academic.with(
  title: "Master Theorem",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 4, pp. 9–10, 14–16
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Statement
For $T(n)=a T(n/b)+f(n)$ with $a>=1$, $b>1$, let
$ d=log_b a, quad n^d=n^(log_b a). $
Compare the work outside recursion, $f(n)$, with $n^d$.

== Three standard cases
*Case 1: recursive leaves dominate.* If $f(n)=O(n^(d-epsilon))$ for some $epsilon>0$, then
$ T(n)=Theta(n^d). $

*Case 2: balanced levels.* If $f(n)=Theta(n^d)$, then
$ T(n)=Theta(n^d log n). $

*Case 3: top-level combine work dominates.* If $f(n)=Omega(n^(d+epsilon))$ for some $epsilon>0$ and the regularity condition $a f(n/b)<=c f(n)$ for some $c<1$ holds eventually, then
$ T(n)=Theta(f(n)). $

== Examples from your notebook
- $T(n)=4T(n/2)+n$: $d=2$, Case 1, so $Theta(n^2)$.
- $T(n)=2T(n/2)+n$: $d=1$, Case 2, so $Theta(n log n)$.
- $T(n)=2T(n/2)+n^2$: $d=1$, Case 3, so $Theta(n^2)$.
- $T(n)=T(n/2)+1$: $d=0$, Case 2, so $Theta(log n)$.
- $T(n)=3T(n/2)+n$: $d=log_2 3$, Case 1, so $Theta(n^(log_2 3))$.

== Logarithmic factors: an extension
Your notes also sketch the common polynomial-log extension. If $f(n)=Theta(n^d (log n)^k)$ with $k>=0$, then $T(n)=Theta(n^d(log n)^(k+1))$. In particular, $T(n)=2T(n/2)+n log n$ is $Theta(n(log n)^2)$.

*Warning:* The basic three-case theorem as written above does not directly cover every $f(n)$ (especially gaps such as $n^d/log n$). Check the exact theorem version your instructor expects.
