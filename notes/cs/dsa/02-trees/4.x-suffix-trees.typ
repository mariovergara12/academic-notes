#import "/templates/academic.typ": *
#show: academic.with(
  title: "Suffix Trees and Suffix Arrays",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, pp. 9–12
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Motivation from the reading notes
Your notes use `banana` and describe a *suffix tree* that shares common prefixes of its suffixes rather than storing each suffix independently. The suffixes are:
`banana`, `anana`, `nana`, `ana`, `na`, `a` (and sometimes an explicit unique terminal symbol).

== Compressed edges
A compressed suffix tree can combine a chain of one-child nodes into one edge labeled by a whole substring. Rather than copying substrings, edges can store `(start, end)` offsets into the source string.

== Search for a pattern $P$
Begin at root and follow edge labels matching consecutive characters of $P$. If every character is matched, the pattern occurs in the text; an edge mismatch rules it out.

== Suffix tree vs suffix array
- *Suffix array:* all starting positions of suffixes, sorted lexicographically.
- *Suffix tree:* a compressed branching representation of shared suffix prefixes.

Both support substring queries, but they use different layouts and engineering tradeoffs.

== Bounds and clarification
Once a suffix tree is constructed, following a pattern of length $m$ takes $O(m)$ character work in a standard indexed representation. Building a suffix tree can be $O(n)$ using specialized algorithms and a suitable alphabet model, but *naively inserting all suffixes* can take $Theta(n^2)$.

This section is a reading-note topic, not the same data structure as the ordinary prefix trie above.
