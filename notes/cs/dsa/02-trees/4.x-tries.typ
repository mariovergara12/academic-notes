#import "/templates/academic.typ": *
#show: academic.with(
  title: "Tries (Prefix Trees)",
  course: "Data Structures & Algorithms",
  semester: "Fall 2026",
)

// Sources: Part 2, pp. 16–18, 20–21
// This is a corrected and expanded study-note reconstruction, not a verbatim transcript.

= Trie structure
A trie stores strings along root-to-node paths. Each edge represents a character. A Boolean terminal flag distinguishes a complete stored word from a mere prefix.

#image("../diagrams/trie-cat-car.svg", width: 66%)

The example stores `cat`, `car`, and `dog`. A mark `*` means the word ends at that node.

== Search/contains
```text
contains(word):
    node = root
    for character ch in word:
        if node has no edge ch: return false
        node = child(ch)
    return node.isEnd
```

== Insert
Traverse each character, creating missing child nodes, then set `isEnd = true` at the final node. Inserting the same word again need not create duplicate entries.

== Prefix search
Follow the prefix characters exactly as above but *do not require* `isEnd` at the terminal node. Example: `ca` is a prefix of `cat` and `car` even if the word `ca` was never inserted.

== Count words below a node
If asked to implement `numEntries(node)`, count terminal markers in the subtree:
```cpp
int numEntries(TrieNode* x) {
    if (!x) return 0;
    int result = x->isEnd ? 1 : 0;
    for (TrieNode* child : x->children)
        result += numEntries(child);
    return result;
}
```
This counts words *stored under that node*, not just children and not the number of nodes. Without cached subtree counts, runtime is $Theta(S)$ for $S$ reachable trie nodes.

== Complexity
Insert, exact search and prefix search visit $L$ characters: $O(L)$ time with expected $O(1)$ child lookup (or fixed alphabet array). This is independent of the number of stored words, but memory can be large.
