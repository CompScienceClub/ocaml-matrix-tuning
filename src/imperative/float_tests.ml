module M = Matrix_math.Make(Float)
open Array
open Random
open Unix
open M


(* Basic functionality tests *)
let _ = assert ( 2. <*>> [|1.;2.|] = [|2.;4.|] );;
let _ = assert ( 2. <*>>> [|[|1.;2.|];[|3.;4.|]|] = [|[|2.;4.|];[|6.;8.|]|] );;
let _ = assert ( [|1.;2.|] <<+>> [|1.;2.|] = [|2.;4.|] );;
let _ = assert ( [|[|1.;2.|];[|3.;4.|]|] <<<+>>> [|[|1.;2.|];[|3.;4.|]|] = [|[|2.;4.|];[|6.;8.|]|] );;
let _ = assert ( [|1.;2.|] <<->> [|1.;2.|] = [|0.;0.|] );;
let _ = assert ( [|[|1.;2.|];[|3.;4.|]|] <<<->>> [|[|1.;2.|];[|3.;4.|]|] = [|[|0.;0.|];[|0.;0.|]|] );;
let _ = assert ( [|1.;2.|] <<|.|>> [|1.;2.|] = [|1.;4.|] );;
let _ = assert ( [|[|1.;2.|];[|2.;1.|]|] <<<|.|>>> [|[|2.;1.|];[|1.;2.|]|] = [|[|2.;2.|];[|2.;2.|]|] );;
let _ = assert ( [|1.;2.|] <<.>> [|2.;2.|] = 6. );;
let _ = assert ( [|1.;2.|] <<*>> [|2.;1.|] = [|[|2.;1.|];[|4.;2.|]|]);;
let _ = assert ( [|[|1.;0.|];[|0.;1.|]|] <<<*>> [|1.;0.|] = [|1.;0.|] );;
let _ = assert ( [|[|1.;0.|];[|0.;1.|]|] <<<*>>> [|[|1.;0.|];[|0.;1.|]|] = [|[|1.;0.|];[|0.;1.|]|] );;
let _ = assert ( transpose [|[|1.;2.|];[|3.;4.|]|] = [|[|1.;3.|];[|2.;4.|]|] );;

let _ = Printf.printf "All basic tests passed!\n";;


(* Speed test *)
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

let t1 = get_time ();;
let m  = gen_matrix 4000
and v  = gen_vector 4000;;
let t2 = get_time ();;
let _  = m <<<*>> v;;
let t3 = get_time ();;

Printf.printf "Initialization: %.4f seconds.\n" (t2 -. t1);;
Printf.printf "Multiplication: %.4f seconds.\n" (t3 -. t2);;
