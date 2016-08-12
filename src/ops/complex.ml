type {re: float; im: float}

let zero    = {re = 0.; im = 0.} 
let add x y = {re = x.re +. y.re; im = x.im +. y.im}
let sub x y = {re = x.re -. y.re; im = x.im -. y.im}
let mul x y = {re = x.re *. y.re -. x.im *. y.im;
               im = x.re *. y.im +. x.im *. y.re}  
