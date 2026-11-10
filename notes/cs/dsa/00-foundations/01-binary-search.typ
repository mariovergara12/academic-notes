#import "/templates/academic.typ": *
#show: academic.with(
  title: "Binary Search",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 1, pp. 1, 4
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Idea
Binary search locates a target in a *sorted* array by repeatedly discarding half of the remaining search interval. Your first scan illustrates searching for `16` in `[2, 5, 8, 12, 16, 23, 38]`.

== Iterative C++ implementation
```cpp
int binarySearch(const vector<int>& a, int target) {
    int lo = 0, hi = static_cast<int>(a.size()) - 1;
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;
        if (a[mid] == target) return mid;
        if (a[mid] < target) lo = mid + 1;
        else hi = mid - 1;
    }
    return -1;
}
```

== Why it works
At each iteration, *invariant:* if the target is present, it lies in the inclusive interval `[lo, hi]`. Since the array is sorted, a comparison with the middle rules out an entire side, preserving the invariant.

== Runtime
After $k$ unsuccessful rounds, at most $n/2^k$ positions remain. Solve $n/2^k <= 1$ to obtain $k >= log_2 n$.
- Best: $Theta(1)$ if the first midpoint matches.
- Worst: $Theta(log n)$ comparisons.
- Space: $Theta(1)$ for the iterative version.

*Exam trap:* Binary search does not work on an unsorted array without additional structure. Remember to update to `mid ± 1` or the interval may fail to shrink.
