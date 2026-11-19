#import "/templates/academic.typ": *

#show: academic.with(
  title: "Dynamic Programming",
  course: "CSCI 3333 — Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Source: Mark Allen Weiss, 4th ed., Section 10.3

= 10.3 — Dynamic Programming

#definition[
  *Dynamic programming (DP)* is an algorithm design
  technique that solves overlapping subproblems once
  and stores their solutions for future use.
]

Dynamic programming is useful when a problem exhibits:

- *Overlapping subproblems:* The same subproblems are solved repeatedly.
- *Optimal substructure:* An optimal solution can be constructed from optimal solutions to smaller subproblems.

The central idea is to avoid repeated computation.

== Dynamic Programming vs. Divide and Conquer

*Divide and conquer:*
- Breaks a problem into smaller subproblems.
- Usually solves independent subproblems recursively.
- Combines their solutions.

*Dynamic programming:*
- Subproblems may overlap.
- Stores previously computed results.
- Reuses answers instead of recomputing them.

Two common implementation strategies:

- *Memoization (top-down):* Recursive computation with caching.
- *Tabulation (bottom-up):* Compute answers in a table, starting with the smallest subproblems.

= 10.3.1 — Using a Table Instead of Recursion

== Fibonacci Numbers

Weiss uses Fibonacci numbers to demonstrate why
repeated recursive calls can be inefficient.

Using the book's initial conditions:

$
  F_0 = F_1 = 1
$

$
  F_n = F_(n-1) + F_(n-2)
$

A naive recursive implementation evaluates both
$F_(n-1)$ and $F_(n-2)$ at every non-base call.

For example:

$
  F_5 = F_4 + F_3
$

But $F_4$ itself requires another evaluation of $F_3$.

Thus, the same values are computed repeatedly.

*Naive recursion:*

$
  T(n) = T(n-1) + T(n-2) + Theta(1)
$

Its running time is exponential.

== Bottom-Up Solution

Instead of recomputing previous values:

+ Compute the base cases.
+ Store previously calculated values.
+ Compute each new value from earlier results.

Because Fibonacci requires only the previous two
values, the entire table is unnecessary.

#example[
  *Fibonacci with constant extra space*

  ```cpp
  long long fibonacci(int n)
  {
      if (n <= 1)
          return 1;

      long long previous = 1;
      long long current = 1;

      for (int index = 2; index <= n; ++index)
      {
          long long next = previous + current;
          previous = current;
          current = next;
      }

      return current;
  }
  ```

  Time: $Theta(n)$

  Extra space: $Theta(1)$
]

*Key lesson:* Store only the previous results
that are actually needed.

== Another Example: Evaluating a Recurrence

Weiss also examines the recurrence:

$
  C(n) = 2/n sum_(i=0)^(n-1) C(i) + n
$

with

$
  C(0) = 1
$

Direct recursion repeatedly evaluates the same
previous values and leads to exponential work.

Using a table eliminates this repeated recursion.

However, a direct tabulation algorithm still
recalculates the entire sum for each $n$:

$
  T(n) = Theta(n^2)
$

We can improve it by maintaining a running sum:

$
  S(n) = sum_(i=0)^n C(i)
$

Then:

$
  C(n) = 2/n S(n-1) + n
$

and

$
  S(n) = S(n-1) + C(n)
$

Each new result now requires constant time.

$
  T(n) = Theta(n)
$

*Important:* Dynamic programming does not
automatically produce the most efficient algorithm.
The recurrence and table updates can often be improved.

= 10.3.2 — Ordering Matrix Multiplications

== Problem

Given matrices

$
  A_1 A_2 dots A_n
$

determine the parenthesization that minimizes
the total number of scalar multiplications.

Matrix multiplication is *associative*:

$
  (A B) C = A (B C)
$

But different multiplication orders can have
very different computational costs.

If $A$ is $p times q$ and $B$ is $q times r$,
computing $A B$ requires

$
  p q r
$

scalar multiplications.

== Example from Weiss

Consider four matrices:

$
  A: 50 times 10
$

$
  B: 10 times 40
$

$
  C: 40 times 30
$

$
  D: 30 times 5
$

One possible order is

$
  ((A B) C) D
$

Its total cost is

$
  20,000 + 60,000 + 7,500 = 87,500
$

But another ordering is

$
  A (B (C D))
$

Its cost is

$
  6,000 + 2,000 + 2,500 = 10,500
$

#example[
  The optimal ordering for this example is

  $
    A (B (C D))
  $

  requiring only

  $
    10,500
  $

  scalar multiplications.
]

Thus, optimal parenthesization can dramatically
reduce computation without changing the result.

== Dynamic Programming Recurrence

Let

$
  M_(i,j)
$

be the minimum number of scalar multiplications
needed to compute

$
  A_i A_(i+1) dots A_j
$

*Base case:*

$
  M_(i,i) = 0
$

A single matrix requires no multiplication.

Suppose the final multiplication splits the chain
between matrices $k$ and $k+1$.

Then the cost is:

$
  M_(i,k) + M_(k+1,j) + p_(i-1) p_k p_j
$

where matrix $A_i$ has dimensions
$p_(i-1) times p_i$.

Try every possible splitting position:

#theorem[
  *Matrix-chain recurrence*

  $
    M_(i,j) =
    min_(i <= k < j) (
      M_(i,k) + M_(k+1,j)
      + p_(i-1) p_k p_j
    )
  $

  with $M_(i,i) = 0$.
]

== Table Computation

Compute the table by increasing chain length:

+ Initialize $M_(i,i) = 0$.
+ Solve chains containing two matrices.
+ Solve chains containing three matrices.
+ Continue until the complete chain is solved.
+ Record the optimal splitting position to reconstruct the parenthesization.

*Complexity:*

$
  T(n) = O(n^3)
$

$
  S(n) = O(n^2)
$

The cubic time follows from trying possible split
positions for each of $O(n^2)$ subproblems.

*Key insight:* The optimal ordering contains
optimal orderings of its left and right subchains.

= 10.3.3 — Optimal Binary Search Tree

== Problem

Given sorted keys

$
  w_1 < w_2 < dots < w_n
$

with access probabilities

$
  p_1, p_2, dots, p_n
$

construct a binary search tree that minimizes
the expected search cost.

A BST requires approximately

$
  1 + d_i
$

comparisons to find a key at depth $d_i$.

Therefore, expected search cost is

$
  E = sum_(i=1)^n p_i (1 + d_i)
$

We want to minimize $E$.

== Why a Balanced BST Is Not Always Optimal

If every key is equally likely to be accessed,
a balanced BST is generally desirable.

But if some keys are accessed more frequently,
placing them closer to the root may reduce
expected search cost.

Weiss compares three possible trees:

- Greedy tree (most probable key as root): $2.43$.
- Perfectly balanced tree: $2.70$.
- Optimal tree found by DP: $2.15$.

Thus, neither the obvious greedy strategy
nor perfect balancing necessarily gives
the optimal search tree.

== Dynamic Programming Recurrence

Let

$
  C_(l,r)
$

be the minimum expected search cost for the
sorted keys from position $l$ through $r$,
measured relative to that subtree's root.

*Base case:*

$
  C_(l,r) = 0
$

for $l > r$.

Choose a possible root $k$, where

$
  l <= k <= r
$

Then:

- Left subtree contains keys $l$ through $k-1$.
- Right subtree contains keys $k+1$ through $r$.
- Every key in either subtree becomes one level deeper.

Therefore, an additional cost equal to the
total probability of the subrange must be added.

#theorem[
  *Optimal BST recurrence*

  $
    C_(l,r) =
    min_(l <= k <= r) (
      C_(l,k-1) + C_(k+1,r)
    )
    + sum_(i=l)^r p_i
  $
]

Try each possible root and choose the one
producing the smallest expected cost.

Store the chosen root to reconstruct the tree.

*Complexity of the textbook's DP:*

$
  T(n) = O(n^3)
$

$
  S(n) = O(n^2)
$

Using prefix sums, subrange probability sums
can be calculated in constant time.

*Key insight:* An optimal BST requires optimal
left and right subtrees for each chosen root.

= 10.3.4 — All-Pairs Shortest Path

== Problem

Given a weighted directed graph

$
  G = (V, E)
$

find the shortest-path distance between
*every pair of vertices*.

This differs from single-source shortest paths,
which begin from only one source vertex.

Weiss uses the dynamic programming algorithm
commonly known as *Floyd-Warshall*.

== Dynamic Programming State

Let

$
  D_(k,i,j)
$

represent the length of the shortest path
from vertex $i$ to vertex $j$ using only
vertices $1, 2, dots, k$ as intermediates.

*Base case:*

$
  D_(0,i,j) = w_(i,j)
$

where $w_(i,j)$ is the direct edge weight,
infinity if no edge exists, and zero when $i = j$.

== Recurrence

For each possible intermediate vertex $k$,
there are two possibilities:

+ The shortest path from $i$ to $j$ does not use $k$.
+ The shortest path uses $k$, dividing into paths $i$ to $k$ and $k$ to $j$.

Therefore:

#theorem[
  *Floyd-Warshall recurrence*

  $
    D_(k,i,j) = min(
      D_(k-1,i,j),
      D_(k-1,i,k) + D_(k-1,k,j)
    )
  $
]

The algorithm checks whether traveling through
vertex $k$ improves the current shortest path.

== Algorithm

```cpp
for (int intermediate = 0; intermediate < vertexCount;
     ++intermediate)
{
    for (int source = 0; source < vertexCount; ++source)
    {
        for (int destination = 0;
             destination < vertexCount; ++destination)
        {
            distance[source][destination] =
                min(distance[source][destination],
                    distance[source][intermediate]
                    + distance[intermediate][destination]);
        }
    }
}
```

The implementation uses one distance matrix
and updates it in place.

A separate matrix can record intermediate
vertices to reconstruct the actual paths.

== Complexity

Three nested loops over the vertices:

$
  T(V) = O(V^3)
$

The distance matrix contains one entry
for every ordered vertex pair:

$
  S(V) = O(V^2)
$

Here, $V$ denotes the number of vertices.

Floyd-Warshall supports negative edge weights,
provided there are no negative-weight cycles
affecting the shortest-path problem.

Dijkstra's algorithm, by contrast, requires
nonnegative edge weights for its usual guarantee.

= Summary — Dynamic Programming

#table(
  columns: (1.4fr, 1.5fr, 1fr),
  inset: 6pt,
  [*Problem*], [*Key State*], [*Runtime*],
  [Fibonacci], [Previous values], [$Theta(n)$],
  [Matrix-chain order], [$M_(i,j)$], [$O(n^3)$],
  [Optimal BST], [$C_(l,r)$], [$O(n^3)$],
  [All-pairs shortest path], [$D_(k,i,j)$], [$O(V^3)$],
)

#callout("Essential Ideas", [
  *1. Repeated subproblems:* Store solutions instead of
  recomputing them.

  *2. Optimal substructure:* Optimal solutions can be
  assembled from optimal smaller solutions.

  *3. State:* Define exactly what each DP table entry
  represents.

  *4. Recurrence:* Express the current state in terms
  of previously solved states.

  *5. Evaluation order:* Compute dependencies before
  the states that need them.
])

== Steps for Designing a DP Algorithm

+ Identify the subproblem and define the state.
+ Determine the base cases.
+ Derive a recurrence using smaller subproblems.
+ Choose memoization or bottom-up tabulation.
+ Determine the order in which states are evaluated.
+ Analyze time and space complexity.
+ Record decisions if the actual optimal solution
  must be reconstructed.

= Practice Questions

+ Why is naive recursive Fibonacci exponential,
  while the iterative algorithm is linear?

+ Explain why different matrix-chain parenthesizations
  can have different costs.

+ What does $M_(i,j)$ represent in matrix-chain
  multiplication?

+ Why might the optimal BST not be perfectly balanced?

+ Explain the additional probability term in the
  optimal BST recurrence.

+ Derive the Floyd-Warshall recurrence by considering
  whether a shortest path uses intermediate vertex $k$.

+ Explain why Floyd-Warshall requires three nested loops.
