#import "/templates/academic.typ": *
#show: academic.with(
  title: "Expression Trees and Prefix/Postfix",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, p. 1; Part 1, pp. 21–23
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Operators and operands as a tree
Your expression-tree example is $(a+b)*c$. Internal nodes contain operators; leaves contain operands.

#image("../diagrams/expression-tree.svg", width: 60%)

- Infix: `(a + b) * c`.
- Prefix (preorder): `* + a b c`.
- Postfix (postorder): `a b + c *`.

== Why postfix is useful
A stack evaluates postfix expressions without needing parentheses:
1. Push each operand.
2. On an operator, pop operands in the correct order, apply the operation, then push the result.
3. The final stack element is the result.

For subtraction/division, *operand order matters*: the first popped value is the right operand.

All three traversals take $Theta(n)$ where $n$ is the number of tree nodes.
