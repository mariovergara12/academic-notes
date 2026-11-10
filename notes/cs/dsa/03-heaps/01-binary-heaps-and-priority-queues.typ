#import "/templates/academic.typ": *
#show: academic.with(
  title: "Binary Heaps and Priority Queues",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, pp. 22–24; Part 3, pp. 12–13
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= The priority queue ADT
A priority queue lets us efficiently retrieve an element with smallest priority (*min priority queue*) or largest priority (*max priority queue*). A binary heap is a common implementation.

A *min-heap* has two properties: (1) its tree is complete, filled left-to-right, and (2) every parent key is at most its children’s keys.

#image("../diagrams/heap-example.svg", width: 62%)

== Array Representation (0-Based)

A binary heap can be stored in an array without using pointers.

For a node at index $i$, the relationships are:

$
  "parent"(i) = floor((i - 1) / 2)
$

$
  "left"(i) = 2i + 1
$

$
  "right"(i) = 2i + 2
$

The parent formula applies when $i > 0$, since the root has no parent.

For a complete binary heap containing $n$ elements, the height is:

$
  h = floor(log_2 n)
$

Therefore:

$
  h = Theta(log n)
$

In a complete heap of $n$ elements, height is $Theta(log n)$.

== Insert: bubble up
```cpp
void push(vector<int>& h, int x) {
    h.push_back(x);
    int i = static_cast<int>(h.size()) - 1;
    while (i > 0) {
        int p = (i - 1) / 2;
        if (h[p] <= h[i]) break;
        swap(h[p], h[i]);
        i = p;
    }
}
```

== Extract minimum: bubble down
1. Save the root (minimum).
2. Move the last array element to the root and remove the last slot.
3. Swap downward with the *smaller child* until heap order is restored.

== Costs
- `min`/`peek`: $Theta(1)$.
- `insert`: $O(log n)$ worst case.
- `extractMin`: $O(log n)$ worst case.
- Heap construction by bottom-up heapify: $Theta(n)$, not $Theta(n log n)$.

*Exam pitfall:* A heap is *not* a BST. Siblings and arbitrary subtrees need not be ordered, only parent versus child.
