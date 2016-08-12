open Ops
open Matrix
open List

let map  f x   = rev (rev_map  f x)
let map2 f x y = rev (rev_map2 f x y)

module Make(O: Ops) : (Matrix with type scalar = O.t
                              and  type vector = O.t list
                              and  type matrix = O.t list list) =
    struct
        type scalar = O.t
        type vector = O.t list
        type matrix = O.t list list

        let (<*>>)  s v = map (fun x -> O.mul s x) v
        let (<*>>>) s m = map (fun x -> map (fun i -> O.mul s i) x) m

        let (<<+>>)   = map2 (fun x y -> O.add x y)
        let (<<<+>>>) = map2 (fun x y -> map2 (fun i j -> O.add i j) x y) 

        let (<<->>)   = map2 (fun x y -> O.sub x y) 
        let (<<<->>>) = map2 (fun x y -> map2 (fun i j -> O.sub i j) x y) 

        let (<<|.|>>)   = map2 (fun x y -> O.mul x y) 
        let (<<<|.|>>>) = map2 (fun x y -> map2 (fun i j -> O.mul i j) x y) 
 
        let (<<.>>) v1 v2 = 
            let rec aux v1 v2 r =
                match (v1,v2) with
                    | (h1::t1,h2::t2) -> aux t1 t2 (O.add r (O.mul h1 h2)) 
                    | _               -> r
            in 
            aux v1 v2 O.zero

        let (<<*>>) v1 v2 =
            let rec aux v1 v2 r =
                let f v1 v2 = map (fun x -> O.mul (hd v1) x) v2 
                in
                match v1 with
                    | [] -> r
                    | v  -> aux (tl v1) v2 ((f v v2)::r)
            in
            rev (aux v1 v2 [])

        let (<<<*>>) m v =
            let rec aux m v r =
                match (m,v) with
                    | ([]::_,_) -> r
                    | (m, v)    -> aux (map tl m) v (((map hd m) <<.>> v)::r)
            in
            rev (aux m v [])

        let (<<<*>>>) m1 m2 =
            let rec aux m1 m2 r =
                match m2 with
                    | h::t -> aux m1 t ((m1 <<<*>> h)::r)
                    | _    -> r
            in
            rev (aux m1 m2 [])

        let transpose m =
            let rec aux m r =
                match m with
                    | []::_ -> r
                    | m     -> aux (map tl m) ((map hd m)::r)
            in
            rev (aux m [])
    end
