#import "/templates/academic.typ": *
#show: academic.with(
  title: "4.1 Tree Foundations and Height",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 17, 21–24; Part 2, pp. 18–19
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Tree vocabulary
A rooted tree consists of nodes with parent-child links and no cycles. Your notes define *root*, *parent*, *child*, *leaf*, *internal node*, *ancestor*, *descendant*, *subtree*, *depth* and *height*.

- Root depth: $0$.
- Depth of node $v$: number of edges from root to $v$.
- Height of a node: longest number of edges from it to a descendant leaf.
- Height of tree: height of its root; a single-node tree has height $0$ under the edge convention.

== Binary trees
Each node has at most two children. A full binary tree has $2^h$ nodes at level $h$ when all levels are full. A perfect binary tree of height $h$ has
$ n=sum_(i=0)^h 2^i = 2^(h+1)-1. $
Therefore $h=log_2(n+1)-1$ for a perfect binary tree.

*Important distinction:* An arbitrary binary tree with $n$ nodes can have height $n-1$. “Binary tree” alone does not imply logarithmic height.

== Generic depth-first pattern
```cpp
void visit(Node* node) {
    if (!node) return;
    // Process node and/or recursively visit children.
    visit(node->left);
    visit(node->right);
}
```
A full traversal touches all $n$ nodes: $Theta(n)$ time. The recursion stack uses $O(h)$ space.

== Tree terminology and conventions
Some textbooks count height in *nodes*, rather than edges, making the leaf height $1$ instead of $0$. State the convention before proving a bound or writing height-based code.
