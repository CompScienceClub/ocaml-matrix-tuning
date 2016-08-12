module type Ops =
    sig
        type t

        val zero : t
        val add  : t -> t -> t
        val sub  : t -> t -> t
        val mul  : t -> t -> t
    end
