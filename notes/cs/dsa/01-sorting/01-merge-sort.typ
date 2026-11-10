#import "/templates/academic.typ": *
#show: academic.with(
  title: "Merge Sort",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 3, 5, 15–16, 19
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Algorithm
Merge sort is a divide-and-conquer sorting algorithm: split the array in two, recursively sort each half, and merge the two sorted halves. Your example splits `[8,3,2,9]` into `[8,3]` and `[2,9]` before merging.

#image("../diagrams/merge-sort-split.svg", width: 72%)

== Pseudocode
```text
mergeSort(A):
    if length(A) <= 1: return A
    left  = mergeSort(first half)
    right = mergeSort(second half)
    return merge(left, right)
```

The *merge* step compares the first unconsumed element of each half and appends the smaller one, repeating until one half is exhausted. Then append any leftover elements.

== Why merging is linear
Each element is copied or advanced a constant number of times. The total across both halves is $Theta(n)$.

== Complexity
$ T(n)=2T(n/2)+Theta(n)=Theta(n log n). $
- Best/average/worst: $Theta(n log n)$.
- Extra space: typically $Theta(n)$ for the temporary merge buffer.
- Standard merge sort is stable when equal values are taken from the *left* half first.

== C++ core merge idea
```cpp
// Temporary vectors left and right are already sorted.
size_t i = 0, j = 0;
while (i < left.size() && j < right.size()) {
    if (left[i] <= right[j]) out.push_back(left[i++]);
    else out.push_back(right[j++]);
}
while (i < left.size()) out.push_back(left[i++]);
while (j < right.size()) out.push_back(right[j++]);
```

*Exam contrast:* Merge sort's balance is independent of pivot choices. Quick sort can split unevenly.
