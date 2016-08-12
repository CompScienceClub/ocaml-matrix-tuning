open Lacaml.D
open Array
open Random
open Unix

let gen_vector l =
    let v = make l 0.
    in
    for i = 0 to (l - 1) do
        v.(i) <- (float 1.)
    done;
    v

let gen_matrix l = 
    let m = make_matrix l l 0.
    in 
    for i = 0 to (l - 1) do
        m.(i) <- gen_vector l
    done;
    m

let get_time () =
    (times ()).tms_utime +. (times ()).tms_stime

let (<<<*>>) m v = gemv m v

let t1 = get_time ();;
let m  = Mat.of_array (gen_matrix 4000)
and v  = Vec.of_array (gen_vector 4000);;
let t2 = get_time ();;
let _  = m <<<*>> v;;
let t3 = get_time ();;

Printf.printf "Initialization: %.4f seconds.\n" (t2 -. t1);;
Printf.printf "Multiplication: %.4f seconds.\n" (t3 -. t2);;
