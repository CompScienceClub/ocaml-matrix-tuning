## __Matrix Arithmetic in OCaml__

This code is demonstration code for Computer Science Club.  In a previous presentation we
implemented a gradient decent multiple layer backpropagation neural network using, for fun
in demonstration, a mix of functional matrix methods and use of `BLAS` via the `lacaml`
library.  This is a follow-up dealing with implementation of BLAS-like matrix arithmetic.

Superficially, this presentation is about the implementation of various simple operations 
with matrices, such as those that might be used in the problems such as training neural 
networks.  However, it is actually about much more than this.  The object of this code is
to be an avenue for learning about the following:

* Functional programming vs. imperative programming
* Polymorphic types
* Tail recursion
* Modules
* Interfaces
* Functors
* Bounding
* Compiler code generation
* Computation complexity 
* Heap utilization and performance
* Expressiveness
* Testing

This touches on all of these things because the matrix arithmetic is implemented in both
a traditional functional way as well as an imperative way using arrays.  We will see what
the abstractions we use each way look like.  Moreover, we will be looking at specific 
language features and how that effects the code that is produced.  For example, using lists
we would anticipate higher memory use and worse cache performance, but we gain significantly 
in terms of programming abstractions, bounding, etc.  

We will be thinking about the choices we make in our implementation by discussing and at 
times observing the assembly code produced in order to develop skills for evaluating the
tradeoff between expressiveness and performance.




## __How To Build__

The code here requires that you have `make`, `ocamlfind` and `ocamlopt` available.  In order 
to run the baseline test against SGEMV accessed via Lacaml, you will need to also have
BLAS and LAPACK, as well as Lacaml installed.  In order to make the C assembly example, you
will need to have gcc installed.  Some of the lesser known: 

```
yum install blas-devel
```

and

```
yum install lapack-devel
```

on Red Hat (similarly `libblas-dev` and `liblapack-dev` on Debian), and you can

```
opam install lacaml
```


There are four make targets:

```
make functional
```

```
make imperative
```

```
make lacaml
```

```
make c
```


These targets will build an executable in the root bearing the same name, with the 
exception of the C example.  There will be a `_build` directory created that has 
all build products, including `.s` assembly files (though the sgemv one is not all 
that interesting since it has dependency on lacaml and the underlying BLAS and LAPACK 
code).  The C example only build the `.s` output, with no optimization.  The object 
clearly is to see what the code looks like, how fast it runs, and identify the 
relative benefits of each approach.  This is a very high level overview, it is not
intended as a primer on the wealth of differences in implementation in any of the 
languages or interfaces referenced.
