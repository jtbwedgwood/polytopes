# polytopes

This repository is an experiment in using AI agents to formalize Joshua
Hinman's paper "A Positive Answer to Barany's Question on Face Numbers of
Polytopes" in Lean.

## Local Setup

Lean is managed by `elan`, and this repo is a Lake project pinned to the
mathlib-compatible Lean toolchain in `lean-toolchain`.

```bash
source "$HOME/.elan/env"
lake exe cache get
lake build
```

Python tooling for parsing `paper.pdf` lives in a local virtual environment:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

The `code` command-line tool was not available during setup, so the Lean VS Code
extension was not installed automatically. In VS Code, install the official
`lean4` extension by `leanprover` and open this repository folder.

## Current Lean Shape

`Polytopes/Paper.lean` contains the first scaffold:

- imports for convex hulls, binomial coefficients, Euclidean projections,
  finite-dimensional affine geometry, and Lebesgue volume;
- the paper's normalized binomial constant `Polytopes.rho`;
- a temporary `ConvexPolytope` interface for face-number theorem statements;
- placeholders for Lemma 2.11, Theorem 3.2, and Corollary 3.3.

`lake build` succeeds, with warnings only for the deliberate `sorry`
placeholders.

## Formalization Strategy

The practical path is to separate the project into layers.

1. Formalize the pure combinatorial pieces first, especially Lemma 2.11 about
   binomial coefficients. This should be the easiest no-geometry target.
2. Build or locate a finite convex-polytope API: faces, dimensions, facets,
   vertices, f-vectors, simple/simplicial predicates, and duality.
3. Add polytopal complexes and subdivisions only to the extent needed for
   Proposition 3.1.
4. Treat solid angles and the Perles-Shephard theorems as the main hard
   analytic/geometric dependency. A useful intermediate milestone is to state
   these as assumptions, prove Hinman's final counting argument from them, and
   then later replace the assumptions with real proofs or imported results.
5. Keep each paper theorem in a small file with a buildable statement before
   trying to eliminate its `sorry`s.
