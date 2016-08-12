open Ops
open Matrix
open Array

module Make(O: Ops) : (Matrix with type scalar = O.t
                              and  type vector = O.t array
                              and  type matrix = O.t array array) =
    struct
        type scalar = O.t
        type vector = O.t array
        type matrix = O.t array array

        let (<*>>) s v = 
            let l = length v
            in
            let r = make l O.zero
            in
            for i = 0 to (l - 1) do
                r.(i) <- O.mul s v.(i);
            done;
            r

        let (<*>>>) s m =
            let l1 = length m 
            and l2 = length m.(0)
            in
            let r = make_matrix l1 l2 O.zero
            in
            for i = 0 to (l1 - 1) do
                let r2 = make l2 O.zero
                in
                for j = 0 to (l2 -1) do
                    r2.(j) <- O.mul s m.(i).(j);
                done;
                r.(i) <- r2;
            done;
            r

        let (<<+>>) v1 v2 = 
            let l = length v1
            in 
            let r = make l O.zero
            in
            for i = 0 to (l - 1) do
                r.(i) <- O.add v1.(i) v2.(i);
            done;
            r            

        let (<<<+>>>) m1 m2 =  
            let l1 = length m1 
            and l2 = length m1.(0)
            in 
            let r = make_matrix l1 l2 O.zero
            in
            for i = 0 to (l1 - 1) do
                let r2 = make l2 O.zero
                in
                for j = 0 to (l2 -1) do
                    r2.(j) <- O.add m1.(i).(j) m2.(i).(j);
                done;
                r.(i) <- r2;
            done;
            r

        let (<<->>) v1 v2 =  
            let l = length v1
            in
            let r = make l O.zero
            in
            for i = 0 to (l - 1) do
                r.(i) <- O.sub v1.(i) v2.(i);
            done;
            r

        let (<<<->>>) m1 m2 =  
            let l1 = length m1
            and l2 = length m1.(0)
            in 
            let r = make_matrix l1 l2 O.zero
            in
            for i = 0 to (l1 - 1) do
                let r2 = make l2 O.zero
                in
                for j = 0 to (l2 -1) do
                    r2.(j) <- O.sub m1.(i).(j) m2.(i).(j);
                done;
                r.(i) <- r2;
            done;
            r

        let (<<|.|>>) v1 v2 =  
            let l = length v1
            in
            let r = make l O.zero
            in
            for i = 0 to (l - 1) do
                r.(i) <- O.mul v1.(i) v2.(i);
            done;
            r

        let (<<<|.|>>>) m1 m2 =  
            let l1 = length m1 
            and l2 = length m1.(0)
            in 
            let r = make_matrix l1 l2 O.zero
            in
            for i = 0 to (l1 - 1) do
                let r2 = make l2 O.zero
                in
                for j = 0 to (l2 -1) do
                    r2.(j) <- O.mul m1.(i).(j) m2.(i).(j);
                done;
                r.(i) <- r2;
            done;
            r

        let (<<.>>) v1 v2 = 
            let l = length v1
            in
            let r = ref O.zero
            in
            for i = 0 to (l - 1) do
                r := O.add !r (O.mul v1.(i) v2.(i));
            done;
            !r

        let (<<*>>) v1 v2 =
            let l1 = length v1
            and l2 = length v2
            in
            let r = make_matrix l1 l2 O.zero
            in
            for i = 0 to (l1 - 1) do
                let r2 = make l2 O.zero
                in
                for j = 0 to (l2 - 1) do
                    r2.(j) <- O.mul v1.(i) v2.(j);
                done;
                r.(i) <- r2;
            done;
            r

        let (<<<*>>) m v =
            let l1 = length m
            and l2 = length m.(0)
            in 
            let r = make l2 O.zero
            in
            for i = 0 to (l1 - 1) do
                let r2 = ref O.zero
                in
                for j = 0 to (l2 - 1) do
                    r2 := O.add !r2 (O.mul m.(i).(j) v.(j));
                done;
                r.(i) <- !r2;
            done;
            r

        let (<<<*>>>) m1 m2 =
            let l1 = length m1
            and l2 = length m2
            and l3 = length m2.(0)
            in
            let r = make_matrix l1 l3 O.zero
            in
            for i = 0 to (l1 - 1) do
                for j = 0 to (l3 - 1) do
                    let r2 = ref O.zero
                    in
                    for k = 0 to (l2 - 1) do
                        r2 := O.add !r2 (O.mul m1.(i).(k) m2.(k).(j));
                    done;
                    r.(i).(j) <- !r2;
                done;
            done;
            r

        let transpose m =
            let l1 = length m
            and l2 = length m.(0)
            in
            let r = make_matrix l2 l1 O.zero
            in
            for i = 0 to (l1 - 1) do
                for j = 0 to (l2 - 1) do
                    r.(j).(i) <- m.(i).(j);
                done;
            done;
            r
    end
