/-
Copyright (c) 2026 James Wedgwood. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: James Wedgwood, OpenAI Codex
-/
import Mathlib.Analysis.Convex.Hull
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Geometry.Euclidean.Projection
import Mathlib.LinearAlgebra.AffineSpace.FiniteDimensional
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic

/-!
# Hinman's proof of Barany's face-number question

This file is the first Lean-facing scaffold for Joshua Hinman's paper
"A Positive Answer to Barany's Question on Face Numbers of Polytopes".

The paper needs more polytope-specific infrastructure than mathlib currently
appears to expose directly: finite convex polytopes with face posets,
f-vectors, quotient polytopes, polytopal complexes/subdivisions, and solid
angles. The imports above are the mathlib foundations that look immediately
relevant: convex hulls, binomial coefficients, Euclidean projections,
finite-dimensional affine geometry, and Lebesgue volume.
-/

namespace Polytopes

noncomputable section

/--
The normalizing constant

`rho(d, k) = 1 / 2 * (choose (ceil (d / 2)) k + choose (floor (d / 2)) k)`

from the paper. For natural numbers, `ceil (d / 2)` is `(d + 1) / 2`.
-/
def rho (d k : ℕ) : ℚ :=
  ((Nat.choose ((d + 1) / 2) k + Nat.choose (d / 2) k : ℕ) : ℚ) / 2

/--
A temporary interface for the face-number statements in the paper.

This is intentionally not a real definition of convex polytopes. It gives
future formalization work a small stable surface for the theorem statements
while the actual face-poset and geometric API is developed.
-/
structure ConvexPolytope (d : ℕ) where
  faceNumber : ℕ → ℕ
  IsSimple : Prop := False
  IsSimplicial : Prop := False

namespace ConvexPolytope

/-- The number of vertices of a `d`-polytope. -/
def vertices {d : ℕ} (P : ConvexPolytope d) : ℕ :=
  P.faceNumber 0

/-- The number of facets of a `d`-polytope. -/
def facets {d : ℕ} (P : ConvexPolytope d) : ℕ :=
  P.faceNumber (d - 1)

end ConvexPolytope

/--
Paper Lemma 2.11: binomial coefficients are minimized, for fixed sum of the
upper entries, when the two upper entries are as balanced as possible.
-/
theorem choose_balanced_le (a b c : ℕ) :
    Nat.choose ((a + b + 1) / 2) c + Nat.choose ((a + b) / 2) c ≤
      Nat.choose a c + Nat.choose b c := by
  sorry

/--
Paper Theorem 3.2, first inequality. This placeholder uses the temporary
`ConvexPolytope` interface above; it should be restated once the real polytope
definition and f-vector API exist.
-/
theorem face_number_lower_bound_by_vertices {d k : ℕ} (P : ConvexPolytope d) :
    rho d k * (P.vertices : ℚ) ≤ (P.faceNumber k : ℚ) := by
  sorry

/--
Paper Theorem 3.2, second inequality. This placeholder uses the temporary
`ConvexPolytope` interface above; it should be restated once the real polytope
definition and f-vector API exist.
-/
theorem face_number_lower_bound_by_facets {d k : ℕ} (P : ConvexPolytope d) :
    rho d (d - k - 1) * (P.facets : ℚ) ≤ (P.faceNumber k : ℚ) := by
  sorry

/-- Paper Corollary 3.3, Barany's question. -/
theorem barany_face_number_question {d k : ℕ} (P : ConvexPolytope d) :
    min P.vertices P.facets ≤ P.faceNumber k := by
  sorry

end

end Polytopes
