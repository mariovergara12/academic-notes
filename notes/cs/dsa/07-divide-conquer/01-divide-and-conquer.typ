#import "/templates/academic.typ": *
#show: academic.with(
  title: "Divide and Conquer and Recurrence Setup",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 3, 15–17; Part 4, pp. 8, 14–16
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Three stages
Your reading notes list the classic pattern:
1. *Divide:* split into smaller subproblems.
2. *Conquer:* solve subproblems recursively.
3. *Combine:* merge their answers into the original answer.

== Generic recurrence
$ T(n)=a T(n/b)+f(n). $
Here $a$ is the number of subproblems, $b$ is the factor by which each input shrinks, and $f(n)$ is the work performed *outside* recursive calls.

== Key examples
- Binary search: $T(n)=T(n/2)+Theta(1)=Theta(log n)$.
- Merge sort: $T(n)=2T(n/2)+Theta(n)=Theta(n log n)$.
- Karatsuba multiplication: $T(n)=3T(n/2)+Theta(n)=Theta(n^(log_2 3))$.

#image("../diagrams/recursion-tree.svg", width: 66%)

== How to derive a recurrence
Write down: number of recursive calls, size of each call, nonrecursive work, and base case. Then use the Master Theorem or sum the recursion-tree levels. Avoid memorizing formulas without identifying the algorithm's actual work.

== Important limits
Recurrences with uneven sizes (e.g. $T(n/3)+T(2n/3)+n$), variable branching, or unusual extra work may need methods beyond the simple three-case Master Theorem.
