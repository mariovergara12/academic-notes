#import "/templates/academic.typ": *
#show: academic.with(
  title: "AVL Implementation and Height Proof",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, pp. 13, 15, 19, 21; Part 2, pp. 8–9
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Height bookkeeping
Store a cached height at each node. Pick one convention, e.g. null child height $-1$ and leaf height $0$, and use it consistently.

```cpp
int height(Node* x) { return x ? x->height : -1; }
void fix(Node* x) {
    x->height = 1 + max(height(x->left), height(x->right));
}
int balance(Node* x) {
    return height(x->left) - height(x->right);
}
```

== Right rotation (LL fix)
```cpp
Node* rotateRight(Node* y) {
    Node* x = y->left;
    Node* middle = x->right;
    x->right = y;
    y->left = middle;
    fix(y);       // update lower node first
    fix(x);
    return x;     // new root of this subtree
}
```
Left rotation is symmetric. For LR/RL, first rotate the child in the opposite direction, then rotate the original root.

== Insertion outline
1. Perform ordinary recursive BST insertion.
2. On return, update stored heights.
3. Compute balance factor.
4. If $|"BF"|>1$, choose LL/LR/RR/RL from the inserted key's path; rotate and return the subtree's new root.

== Why the height is logarithmic
Let $N(h)$ be the *minimum* number of nodes in an AVL tree of height $h$. Under height-in-edges convention,
$ N(-1)=0, quad N(0)=1, $
$ N(h)=1+N(h-1)+N(h-2). $
The minimum-height-compliant tree has one subtree of height $h-1$ and another of height $h-2$. This Fibonacci-like growth yields $N(h)=Omega(phi^h)$ for $phi=(1+sqrt(5))/2$, hence $h=O(log n)$.

*Important:* The fact that every node is balanced, not merely that the root is balanced, is essential.
