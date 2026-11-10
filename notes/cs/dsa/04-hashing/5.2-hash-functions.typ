#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.2 Hash Functions and Polynomial Hashing",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, pp. 1–2
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Properties of a good hash function
Your notes emphasize fast computation, near-uniform key distribution, and low collision rates. The function must also be *deterministic*: equal keys receive equal hashes.

== Integer keys
A simple example is $h(x)=x mod m$. This is easy to compute but can distribute poorly if the data has patterns related to $m$.

== Strings and polynomial hashing
For character codes $s_0,...,s_(L-1)$, base $b$, and table size $m$, a common polynomial hash is
$ h(s)=(sum_(i=0)^(L-1) s_i b^(L-1-i)) mod m. $

One can evaluate it by Horner's rule, without calculating large powers:
```cpp
size_t hashString(const string& s, size_t mod) {
    size_t value = 0;
    for (unsigned char ch : s)
        value = (value * 33 + ch) % mod;
    return value;
}
```

*Clarification:* The common multiplier `33` is a heuristic used in some practical string hashes; it is not universally optimal. Arithmetic modulo `mod` also prevents intermediate values from growing indefinitely (with sufficiently wide arithmetic).

== Important distinction
A *hash function* only computes an index or hash code. The hash table's *collision-resolution strategy* determines what happens when two keys receive the same index.
