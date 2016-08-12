functional: 
	rm -rf _build
	rm -f functional imperative lacaml
	mkdir _build
	cp src/interface/* _build
	cp src/ops/float.ml _build
	cp src/functional/matrix_math.ml _build
	cp src/functional/float_tests.ml _build
	cd _build && ocamlfind ocamlopt unix.cmxa -S -inline 20 -o functional ops.mli matrix.mli matrix_math.ml float.ml float_tests.ml
	cp _build/functional .

imperative: 
	rm -rf _build
	rm -f functional imperative lacaml
	mkdir _build
	cp src/interface/* _build
	cp src/ops/float.ml _build
	cp src/imperative/matrix_math.ml _build
	cp src/imperative/float_tests.ml _build
	cd _build && ocamlfind ocamlopt unix.cmxa -S -unsafe -inline 20 -o imperative ops.mli matrix.mli matrix_math.ml float.ml float_tests.ml
	cp _build/imperative .

lacaml: 
	rm -rf _build
	rm -f functional imperative lacaml
	mkdir _build
	cp src/lacaml/* _build
	cd _build && ocamlfind ocamlopt -linkpkg -package lacaml -S -o lacaml mult_mv.ml
	cp _build/lacaml .

c:
	rm -rf _build
	rm -f functional imperative lacaml
	mkdir _build
	cp src/c/* _build
	cd _build && gcc -c -S *.c

clean:
	rm -rf _build
	rm -f functional imperative lacaml
