#import "/templates/academic.typ": *

#show: academic.with(
  title: "4.4 AVL Trees and Rotations",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, pp. 8–9, 13, 15, 19

= Motivation

A regular Binary Search Tree (BST) can become unbalanced and degenerate into a chain.

In the worst case, its height becomes:

$
  h = Theta(n)
$

An *AVL tree* is a self-balancing BST that maintains a height-balance condition after every insertion and deletion.

This guarantees logarithmic height.

== Balance Factor

The balance factor of a node measures the difference between the heights of its left and right subtrees.

For a node $v$, define:

$
  "BF"(v) = h(v."left") - h(v."right")
$

For every node in an AVL tree:

$
  "BF"(v) in (-1, 0, 1)
$

Equivalently:

$
  abs("BF"(v)) <= 1
$

Interpretation:

- $"BF"(v) = -1$: Right subtree is taller.
- $"BF"(v) = 0$: Both subtrees have equal height.
- $"BF"(v) = 1$: Left subtree is taller.

Some textbooks use the opposite sign convention.

Regardless of convention, the absolute balance factor must not exceed one.

== Rotation Cases

When a node becomes unbalanced, rotations restore the AVL property.

There are four cases:

=== Left-Left (LL)

Occurs when the imbalance is in the left subtree of the left child.

*Solution:* Perform a right rotation at the unbalanced node.

=== Right-Right (RR)

Occurs when the imbalance is in the right subtree of the right child.

*Solution:* Perform a left rotation at the unbalanced node.

=== Left-Right (LR)

Occurs when the imbalance is in the right subtree of the left child.

*Solution:*

1. Rotate left at the left child.
2. Rotate right at the unbalanced node.

=== Right-Left (RL)

Occurs when the imbalance is in the left subtree of the right child.

*Solution:*

1. Rotate right at the right child.
2. Rotate left at the unbalanced node.

== LL Rotation Example

Suppose we insert the values:

`30, 20, 10`

The resulting BST is left-heavy.

#image("../diagrams/avl-ll-before.svg", width: 52%)

The balance factor of node `30` becomes:

$
  "BF"(30) = 2
$

Since this violates the AVL condition, perform a right rotation at `30`.

#image("../diagrams/avl-ll-after.svg", width: 52%)

The resulting tree has `20` as its root, with `10` and `30` as children.

Every node now satisfies the AVL balance condition.

== LR Rotation Example

Suppose we insert:

`30, 10, 20`

This creates a left-right imbalance.

#image("../diagrams/avl-lr-before.svg", width: 52%)

A single right rotation would not restore balance.

Instead:

1. Rotate left at node `10`.
2. Rotate right at node `30`.

#image("../diagrams/avl-rotated.svg", width: 52%)

The resulting tree has:

- Root: `20`
- Left child: `10`
- Right child: `30`

All balance factors are now within the permitted range.

== Why Rotations Preserve BST Ordering

A rotation changes the parent-child relationships between nodes without changing their inorder traversal.

For example, before rotation:

$
  10 < 20 < 30
$

After rotation, the inorder sequence remains:

$
  10 < 20 < 30
$

Therefore, rotations preserve the BST ordering property while allowing the tree to regain balance.

== Runtime Analysis

An AVL tree containing $n$ nodes has height:

$
  h = Theta(log n)
$

Therefore, the following operations have worst-case running time:

#table(
  columns: (1fr, 1fr),
  [*Operation*], [*Worst-Case Time*],
  [Search], [$O(log n)$],
  [Insertion], [$O(log n)$],
  [Deletion], [$O(log n)$],
  [Single Rotation], [$O(1)$],
  [Double Rotation], [$O(1)$],
)

Each rotation takes constant time because it changes only a fixed number of pointers and updates a fixed number of cached heights.

== Important Takeaways

- AVL trees are self-balancing binary search trees.
- Every node must satisfy the AVL balance condition.
- A balance factor outside the interval from $-1$ to $1$ indicates an imbalance.
- LL and RR require single rotations.
- LR and RL require double rotations.
- Rotations preserve the BST ordering property.
- AVL trees guarantee $O(log n)$ search, insertion, and deletion.
