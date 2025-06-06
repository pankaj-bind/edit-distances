[![Build status](https://github.com/pharo-ai/edit-distances/workflows/CI/badge.svg)](https://github.com/pharo-ai/edit-distances/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/edit-distances/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/edit-distances?branch=master)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Pharo version](https://img.shields.io/badge/Pharo-9-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-13-%23aac9ff.svg)](https://pharo.org/download)
[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)

## Table of contents

- [Table of contents](#table-of-contents)
- [Description](#description)
- [How to install it](#how-to-install-it)
- [How to depend on it](#how-to-depend-on-it)
- [Implemented distances](#implemented-distances)

## Description

Edit distance is a way of quantifying how dissimilar or similar two strings are to one another by counting the minimum number of operations required to transform one string into the other. The distance between the two documents is defined as "The minimum number of insertions, deletions, and substitutions required to transform one string into the other". Edit-based distances for which such weights can be defined are usually refered to as generalized distances. These methods are independent of a searching algorithm, i.e. Levenshtein or Hamming edit distances can be applied separately to a searching algorithm.

Edit distances find applications in natural language processing, where automatic spelling correction can determine candidate corrections for a misspelled word by selecting words from a dictionary that have a low distance to the word in question.

This package provides methods to determine the distance between two objects, for example, between Strings. Those objects, often represent documents. Normally they are strings but also they can be arrays of numbers that represent a document.

  - An edit distance does NOT count matches.
  - Some commonly refered "edit distances" compare corresponding elements and require objects of equal length (examples: Euclidean, Manhattan, Hamming,...)
  - To speed up computation, some distances are based in "tokens", and also referred as token-based distances (example: Cosine similarity).

## How to install it

```smalltalk
EpMonitor disableDuring: [
	Metacello new
		repository: 'github://pharo-ai/edit-distances/src';
		baseline: 'AIEditDistances';
		load ]
```

## How to depend on it

If you want to add the AIEditDistances to your Metacello Baselines or Configurations, copy and paste the following expression:

```smalltalk
spec
	baseline: 'AIEditDistances' 
	with: [ spec repository: 'github://pharo-ai/edit-distances/src' ]
```

## Implemented distances

These are the currently implemented distance.

_Note that we are currently working on this project so we will be implementing more distance in the future._

  - [Euclidean norm](#euclidean-norm), also known as Euclidean length, L2 norm, L2 distance, l^2 norm
  - [Manhattan distance](#manhattan-distance), also known as City Block Distance.
  - [Cosine similarity](#cosine-similarity), note this is not the same as TF-IDF.
  - [Levenshtein distance](#levenshtein-distance)
  - [Restricted Damerau-Levenshtein](#restricted-damerau-levenshtein-distance)
  - [Damerau-Levenshtein](#damerau-levenshtein-distance)
  - [Kendall Tau distance](#kendall-tau-distance) (with and without normalization)
  - [Szymkiewicz-Simpson coefficient](#szymkiewicz-Simpson-coefficient)
  - [Shingles similarity](#shingles-similarity)
  - Hamming distance
  - Damerau Levenshtein distance
  - Restricted Damerau Levenshtein distance
  - Helling distance
  - Brew distance
 
All the distances are polymorphic. They have the same API.

To use them, send the message `distanceBetween: and:`.

```st
aDistance distanceBetween: xCollection and: yCollection
```

### Euclidean norm

The Euclidean distance between two points in Euclidean space is the length of a line segment between the two points. It can be calculated from the Cartesian coordinates of the points using the Pythagorean theorem, therefore occasionally being called the Pythagorean distance.

```st
euclideanDistance := AIEuclideanDistance new.

euclideanDistance distanceBetween: #( 0 3 4 5 ) and: #( 7 6 3 -1 ). "9.746794344808963"
```

### Manhattan distance

In the Manhattan distance, the Euclidean geometry is replaced by a new metric in which the distance between two points is the sum of the (absolute) differences of their coordinates.

More formally, we can define the Manhattan distance, also known as the L1-distance, between two points in an Euclidean space with fixed Cartesian coordinate system is defined as the sum of the lengths of the projections of the line segment between the points onto the coordinate axes.

```st
manhattanDistance := AIManhattanDistance new.

manhattanDistance distanceBetween: #( 10 20 10 ) and: #( 10 20 20 ). "10"
```

### Cosine similarity

Cosine similarity is a metric used to determine how similar the documents are irrespective of their size. Mathematically, it measures the cosine of the angle between two vectors projected in a multi-dimensional space.

```st
cosineDistance := AICosineSimilarityDistance new.

cosineDistance distanceBetween: #(3 45 7 2) and: #(2 54 13 15) "0.9722842517123499"
```

### Levenshtein distance

The Levenshtein distance is a string metric for measuring the difference between two sequences. Informally, the Levenshtein distance between two words is the minimum number of single-character edits (insertions, deletions or substitutions) required to change one word into the other.

```st
levenshteinDistance := AILevenshteinDistance new.

levenshteinDistance distanceBetween: 'zork' and: 'fork' "1"
```
### Restricted Damerau-Levenshtein distance

The restricted Damerau-Lavenshtein distance, also known as the optimal string alignment distance or restricted edit distance is a string metric for measuring the edit distance between two sequences.

This distance differs from the classical Levenshtein distance by including transpositions (swap) among its allowable operations in addition to the three classical single-character edit operations (insertions, deletions and substitutions).

How to use it on Playground:

```st
restrictedDamerauLevenshtein := AIRestrictedDamerauLevenshteinDistance new.

restrictedDamerauLevenshtein distanceBetween: 'an act' and: 'a cat' "2".
```

Brief explanation :

To go from `'an act'` to `'a cat'` we need to add an `'n'` after the `'a'` and swap the `'ac'` into `'ca'` (instead of substituting `'a'` for `'c'` and `'c` for `'a'`). So in total we did 2 changes, that's why when we press command G (CMD+G) on the code above we have the value of 2.

### Damerau-Levenshtein distance

The Damerau-Lavenshtein distance is a string metric for measuring the edit distance between two sequences.
The difference between this distance and the restricted Damerau-Levenshtein distance consists in that the restricted one computes the number of edit operations needed to make the strings equal under the condition that no substring is edited more than once, *whereas this algorithm presents no such restriction*.

How to use it on Playground:

```st
damerauLevenshtein := AIDamerauLevenshteinDistance new.

damerauLevenshtein distanceBetween: 'a cat' and: 'a abct' "2".
```

Brief explanation :

To go from `'a cat'` to `'a abct'` we need to swap the `'ac'` into `'ca'` (instead of substituting `'a'` for `'c'` and `'c` for `'a'`) and add `'b'` between the edited substring. This last edit wouldn't be possible  because that would require the substring to be edited more than once, which is not allowed in OSA(optimal string alignment). So in total we did 2 changes, that's why when we press command G (CMD+G) on the code above we have the value of 2.

### Kendall Tau distance

The Kendall tau rank distance is a metric that counts the number of pairwise disagreements between two ranking lists. The larger the distance, the more dissimilar the two lists are.

Kendall tau distance is also called bubble-sort distance since it is equivalent to the number of swaps that the bubble sort algorithm would take to place one list in the same order as the other list. The Kendall tau distance was created by Maurice Kendall.

This distance a a little special. The distance itself is the number of discordant pairs that there is between the two ranked lists. But, often the result is normalized. In this implementation we normalize the distance by default. To not normalize the result you must send the message `normalizeResult: false`.

```st
kendallTauDistance := AIKendallTauDistance new.
kendallTauDistance normalizeResult: false.
```

There are two normalizers implemented. If no normalizer is specified, then the default normalized will be used. `AIKendallTauDistance class>>#defaultNormalizer`. Which is the `AIBKendallTauNormalizer`.

- The first normalizer is  `AIBKendallTauNormalizer`. It uses the following formula to normalize the discordant pairs. This is the default normalizer.

`tau_b = (P - Q) / sqrt((P + Q + T) * (P + Q + U))`

Where P is the number of concordant pairs, Q the number of discordant pairs, T the number of ties only in x, and U the number of ties only in y. If a tie occurs for the same pair in both x and y, it is not added to either T or U.

- The second normalizer that we have is the `AICKendallTauNormalizer`. It has the following formula:

`tau_c = 2 (P - Q) / (n**2 * (m - 1) / m)`

Where P is the number of concordant pairs, Q the number of discordant pairs. n is the total number of samples, and m is the number of unique values in either x or y, whichever is smaller.

Example with normalization:

```st
kendallTauDistance := AIKendallTauDistance new.

kendallTauDistance distanceBetween: #( 1 2 3 4 5 ) and: #(3 4 1 2 5 ). "(1/5)"
```

Example using another normalizer:

```st
kendallTauDistance := AIKendallTauDistance new.
kendallTauDistance useNormalizer: AICKendallTauNormalizer.

kendallTauDistance distanceBetween: #( 1 2 3 4 5 ) and: #(3 4 1 2 5 ). "(1/5)"
```

Example without normalization:

```st
kendallTauDistance := AIKendallTauDistance new.
kendallTauDistance normalizeResult: false.

kendallTauDistance distanceBetween: #( 1 2 3 4 5 ) and: #(3 4 1 2 5 ). "4"
```

### Szymkiewicz-Simpson coefficient

Also called overlap coefficient, is a similarity measure that measures the overlap between two finite sets. As this distance is conceptually only for sets, it is defined only in the `Set` class. So, we method is expecting an instance of `Set` as an argument.

```st
szymkiewiczSimpsonDistance := AISzymkiewiczSimpsonDistance new.

szymkiewiczSimpsonDistance
	distanceBetween: #( 1000 2 0.5 3 6 88 99 ) asSet
	and: #( 1000 0.5 99 ) asSet. "1.0"
```

### Shingles similarity

A string similarity metric based on Shingles encoding [1]. It is well suited for detecting strings that underwent small modifications. Shingles encoding changes a little when string changes a little.

[1] Broder, Andrei Z. "On the resemblance and containment of documents." Proceedings. Compression and Complexity of SEQUENCES 1997 (Cat. No. 97TB100171). IEEE, 1997.

```st
shinglesSimilarity := AIShinglesSimilarity
  slidingWindowSize: 2
  maxEncodingSize: 5.

shinglesSimilarity distanceBetween: #(lorem ipsum dolor sit amet) and: #(hello world lorem ipsum) "(7/24)"
```

`slidingWindowSize` and `maxEncodingSize` have default values. Note that the result will change acording to the values that are set.

```st
shinglesSimilarity := AIShinglesSimilarity new.

shinglesSimilarity distanceBetween: #(lorem ipsum dolor sit amet) and: #(hello world lorem ipsum) "0"
```
