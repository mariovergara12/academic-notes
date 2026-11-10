#import "/templates/academic.typ": *
#show: academic.with(
  title: "4.3 Binary Search Trees",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, pp. 2–7; Part 1, pp. 23–24
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Binary search tree (BST) property
For each node with key $x$, every key in its left subtree is smaller than $x$, and every key in its right subtree is larger, assuming no duplicates. This *entire-subtree* property is stronger than only comparing immediate children.

#image("../diagrams/bst-example.svg", width: 54%)

== Search
```cpp
Node* find(Node* root, int key) {
    while (root) {
        if (key == root->key) return root;
        root = key < root->key ? root->left : root->right;
    }
    return nullptr;
}
```
In-order traversal visits BST keys in ascending order.

== Insert
Search downward until reaching a null child. Attach the new node there, maintaining the ordering invariant. Decide explicitly how duplicates should be handled (ignore, count, or put on a designated side).

== Delete: three cases
1. *Leaf:* disconnect and delete it.
2. *One child:* splice its single child into its place.
3. *Two children:* replace the deleted key with its *in-order successor* (minimum key in the right subtree) or predecessor, then delete that key from its old location.

#image("../diagrams/bst-delete.svg", width: 52%)

== Runtime
Search, insert, and delete take $Theta(h)$ time where $h$ is tree height.
- Balanced BST: $h=Theta(log n)$.
- Worst-case ordinary BST (sorted insertion): $h=Theta(n)$.
- Finding min/max is also $O(h)$ by following left/right pointers.

*Exam pitfall:* Do not assert all BSTs are $O(log n)$; a plain BST need not stay balanced.
