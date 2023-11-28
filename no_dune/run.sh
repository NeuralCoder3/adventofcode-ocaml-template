# without .ml
INPUT=${1%.*}
# ocamlc str.cma utils.ml $INPUT.ml -o $INPUT.out && ./$INPUT.out
# ocamlc -I +str str.cma utils.ml $INPUT.ml -o $INPUT.out && ./$INPUT.out
ocamlfind ocamlopt -package lp,lp-glpk -linkpkg -o main.out utils.ml $INPUT.ml && ./main.out