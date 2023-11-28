# Advent of Code OCaml Template

[Advent of Code](https://adventofcode.com/2020/about) is an online advent calendar with coding challenges.

Here, we provide a small template and some useful helper functions (in `lib/utils.ml`) to ease the start.
Additionally, this project and be used as dune getting-started guide.

The aim is not to teach best-practices or to generate optimal code.
We want to restrict ourselfves to "basic" vanilla OCaml without too advanced libraries.

To create a solution for a new day, simply download the input files to `inputs`,
copy `bin/template.ml` to `bin/aoc[n].ml`, and change the import in `bin/main.ml` to
`open Aoc[n]`.

Execute the program using `dune exec aoc`.

For ease of development, we added a Dockerfile and `devcontainer` environment in which you can develop.

Have fun puzzling!