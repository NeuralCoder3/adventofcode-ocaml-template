FROM ocaml/opam

RUN sudo apt install -y libglpk-dev z3 python3

RUN opam pin lp --dev-repo && \
    opam pin lp-glpk --dev-repo && \
    opam install lp lp-glpk && \
    opam pin lp-glpk-js --dev-repo && \
    opam install lp-glpk-js

RUN opam install ocaml-lsp-server ocamlformat merlin
RUN opam user-setup install

RUN opam install base batteries zarith
