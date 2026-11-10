#import "/templates/academic.typ": *

#show: academic.with(
  title: "Quick Sort and Partitioning",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 2, 5–6, 19

= Core Idea

Quick sort is a divide-and-conquer sorting algorithm.

It works by:

1. Choosing an element called the *pivot*.
2. Partitioning the array around the pivot.
3. Recursively sorting the left and right partitions.

After partitioning, the pivot is in its final sorted position.

The key operation is *partitioning*, which takes $Theta(n)$ time.

== Lomuto-Style C++ Partition

The following implementation chooses the last element as the pivot.

```cpp
int partition(vector<int>& a, int lo, int hi) {
    int pivot = a[hi];
    int i = lo;

    for (int j = lo; j < hi; ++j) {
        if (a[j] <= pivot) {
            swap(a[i], a[j]);
            ++i;
        }
    }

    swap(a[i], a[hi]);
    return i;
}

void quickSort(vector<int>& a, int lo, int hi) {
    if (lo >= hi) return;

    int p = partition(a, lo, hi);

    quickSort(a, lo, p - 1);
    quickSort(a, p + 1, hi);
}
```

== Partition Example

Consider the array:

`[7, 2, 9, 4, 1, 5]`

Choose the last element as the pivot:

$
  "pivot" = 5
$

Initially:

$
  i = 0, quad j = 0
$

Process each element from left to right.

1. `7 > 5`: Do nothing.
2. `2 <= 5`: Swap `7` and `2`.
3. `9 > 5`: Do nothing.
4. `4 <= 5`: Swap `7` and `4`.
5. `1 <= 5`: Swap `9` and `1`.

The array becomes:

`[2, 4, 1, 7, 9, 5]`

Finally, swap the pivot with the element at index `i`.

Result:

`[2, 4, 1, 5, 9, 7]`

The pivot `5` is now in its final sorted position.

== Loop Invariant

A loop invariant is a property that remains true before and after every iteration of a loop.

For the partition algorithm, before each iteration:

- Indices from `lo` to `i - 1` contain values less than or equal to the pivot.
- Indices from `i` to `j - 1` contain values greater than the pivot.
- Indices from `j` to `hi - 1` contain unexamined values.
- Index `hi` stores the pivot.

=== Initialization

Initially:

$
  i = j = "lo"
$

Both processed regions are empty.

Therefore, the invariant holds.

=== Maintenance

For each element `a[j]`:

*Case 1: Element is less than or equal to the pivot.*

- Swap `a[i]` with `a[j]`.
- Increment `i`.
- Continue to the next element.

The region containing values less than or equal to the pivot grows by one element.

*Case 2: Element is greater than the pivot.*

- Leave `i` unchanged.
- Continue to the next element.

The region containing values greater than the pivot grows by one element.

In both cases, the invariant is preserved.

=== Termination

When the loop finishes:

$
  j = "hi"
$

Every element before the pivot has been examined.

Swapping `a[i]` with `a[hi]` places the pivot between the two partitions.

Therefore:

- Every element to the left is less than or equal to the pivot.
- Every element to the right is greater than the pivot.

This establishes the correctness of the partition operation.

== Recurrence and Pivot Choice

=== Balanced Partitions

If the pivot divides the array into two approximately equal parts:

$
  T(n) = 2 T(n / 2) + Theta(n)
$

By the Master Theorem:

$
  T(n) = Theta(n log n)
$

=== Extremely Unbalanced Partitions

If the pivot is repeatedly the smallest or largest element:

$
  T(n) = T(n - 1) + Theta(n)
$

Expanding the recurrence gives:

$
  T(n) = Theta(n^2)
$

=== Randomized Pivot

Choosing a pivot uniformly at random produces expected running time:

$
  E[T(n)] = Theta(n log n)
$

The worst-case running time remains:

$
  T(n) = O(n^2)
$

=== Median-of-Three Pivot

Median-of-three selects the median of three sampled elements, often the first, middle, and last elements.

This can improve partition balance in practice.

However, it does not guarantee balanced partitions.

Therefore, the worst-case running time remains:

$
  T(n) = O(n^2)
$

== Complexity Summary

#table(
  columns: (1fr, 1fr),
  [*Case*], [*Running Time*],
  [Best], [$Theta(n log n)$],
  [Average], [$Theta(n log n)$],
  [Worst], [$Theta(n^2)$],
  [Partition], [$Theta(n)$],
)

For this in-place partition implementation, auxiliary space comes primarily from the recursion stack:

- Balanced recursion: $Theta(log n)$
- Worst-case recursion: $Theta(n)$

== Comparison with Merge Sort

#table(
  columns: (1.2fr, 1fr, 1fr),
  [*Property*], [*Quick Sort*], [*Merge Sort*],
  [Best time], [$Theta(n log n)$], [$Theta(n log n)$],
  [Average time], [$Theta(n log n)$], [$Theta(n log n)$],
  [Worst time], [$Theta(n^2)$], [$Theta(n log n)$],
  [Stable], [Usually no], [Usually yes],
  [Auxiliary space], [Recursion stack], [$Theta(n)$],
)

== Important Takeaways

- Quick sort uses divide and conquer.
- Partitioning takes linear time.
- Pivot selection determines partition balance.
- Balanced partitions give $Theta(n log n)$ time.
- Repeatedly unbalanced partitions give $Theta(n^2)$ time.
- Randomized pivot selection gives expected $Theta(n log n)$ time.
- Median-of-three improves practical performance but does not eliminate the quadratic worst case.
- The loop invariant explains why partitioning correctly positions the pivot.
