#import "/templates/academic.typ": *
#show: academic.with(
  title: "4.2 Tree Traversals",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 21–24; Part 2, p. 1
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Three depth-first traversals
Consider the expression tree for $(a+b)c$:

#image("../diagrams/expression-tree.svg", width: 53%)

- *Preorder* (node, left, right): `* + a b c` — prefix notation.
- *Inorder* (left, node, right): `a + b * c` — add parentheses to preserve the precise expression grouping.
- *Postorder* (left, right, node): `a b + c *` — postfix notation.

== Recursive pseudocode
```cpp
void preorder(Node* x) {
    if (!x) return;
    process(x);
    preorder(x->left);
    preorder(x->right);
}
void inorder(Node* x) {
    if (!x) return;
    inorder(x->left);
    process(x);
    inorder(x->right);
}
void postorder(Node* x) {
    if (!x) return;
    postorder(x->left);
    postorder(x->right);
    process(x);
}
```

== Level-order traversal
Uses a FIFO queue to visit nodes level by level, from left to right.
```cpp
queue<Node*> q;
if (root) q.push(root);
while (!q.empty()) {
    Node* u = q.front(); q.pop();
    process(u);
    if (u->left) q.push(u->left);
    if (u->right) q.push(u->right);
}
```
All traversals are $Theta(n)$ time. Queue space in level order is $O(w)$, where $w$ is the largest level width.
