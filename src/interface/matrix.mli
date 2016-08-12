module type Matrix =
    sig
        type scalar
        type vector
        type matrix
        
        val (<*>>)      : scalar -> vector -> vector  
        val (<*>>>)     : scalar -> matrix -> matrix
        
        val (<<+>>)     : vector -> vector -> vector
        val (<<<+>>>)   : matrix -> matrix -> matrix
                
        val (<<->>)     : vector -> vector -> vector
        val (<<<->>>)   : matrix -> matrix -> matrix
        
        val (<<|.|>>)   : vector -> vector -> vector
        val (<<<|.|>>>) : matrix -> matrix -> matrix
        
        val (<<.>>)     : vector -> vector -> scalar
        val (<<*>>)     : vector -> vector -> matrix 
        val (<<<*>>)    : matrix -> vector -> vector
        val (<<<*>>>)   : matrix -> matrix -> matrix 
        
        val transpose    : matrix -> matrix
    end
