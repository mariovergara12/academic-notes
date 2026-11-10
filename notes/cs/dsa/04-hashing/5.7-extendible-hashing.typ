#import "/templates/academic.typ": *
#show: academic.with(
  title: "5.7 Extendible Hashing",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 3, p. 6
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Disk-oriented dynamic hashing
Extendible hashing organizes disk buckets behind a directory indexed by a prefix of the key's hash bits. The objective is to reduce disk accesses while growing as needed.

== Terms
- *Global depth* $d$: number of hash bits used to index the directory; directory has $2^d$ slots.
- *Local depth* of a bucket: number of hash-prefix bits distinguishing it from other buckets.

== Insert and split
When a disk bucket overflows, split that bucket and redistribute keys according to one additional hash bit. If its local depth already equals global depth, first double the directory, then split the bucket.

== Why different from ordinary rehashing
A conventional full-table resize typically revisits all existing entries. Extendible hashing can grow by splitting *only the overflowing bucket*, plus updating directory references, though directory doubling can still be costly.

*Scope:* Your scan introduces the directory/bucket design but does not develop detailed implementation code; this file supplies the minimum mechanism needed to understand the idea.
