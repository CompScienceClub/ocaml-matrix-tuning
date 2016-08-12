(* Lists type *)
type lst = Empty | Cons of 'a * 'a lst;;

(* 
   Built-in list syntax: 
      - infix :: for Cons 
      - [] for Empty
*)

(* Head of a list *)
let hd x =
    match x with
        | h::_ -> h
        | _    -> failwith "head error";;

(* Tail of a list *)
let tl x =
    match x with
        | _::t -> t
        | _    -> failwith "tail error";;

(* Naive, non tail recursive implementation of map *)
let rec map f x =
    match x with 
        | h::t -> (f h)::(map f t)
        | _    -> [];;

(* Reverse a list *)
let rev x =
    let rec aux x r =
        match x with 
            | h::t -> aux t (h::r)
            | _    -> r
    in
    aux x [];;

(* Tail recursive implementation of map, with reversal *)
let map f x =
    let rec aux f x r =
        match x with
            | h::t -> aux f t ((f h)::r)
            | _    -> r
    in
    rev (aux f x []);;

(* Tail recursive implementation of map2, with reversal *)
let map2 f x y =
    let rec aux f x y r =
        match (x,y) with
            | (h1::t1,h2::t2) -> aux f t1 t2 ((f h1 h2)::r)
            | _               -> r
    in
    rev (aux f x y []);;
