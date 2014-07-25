# Lambda Calculus:
    \ or λ  Denotes lambda  
    .       Denotes dot  
    ()      Denotes order  
    a-z     Denotes names  

## Church encoding:  

    \x.x              # Unit  
    \s.\z.z           # Zero  
    \s.\z.s(z)        # One  
    \s.\z.s(s(z))     # Two  
    \f.\x.f(f(f(x)))  # Three
    \x.\y.x           # True  
    \x.\y.y           # False  

### Addition  

    (\w.(\y.(\x.y(wyx))))  

### Multiplication  

    (\x.(\y.(\z.x(yz))))  

### Division  

    (\n.((\f.(\x.xx)(\x.f(xx)))(\c.\n.\m.\f.\x.(\d.(\n.n(\x.(\a.\b.b))(\a.\b.a))d((\f.\x.x)fx)(f(cdmfx)))((\m.\n.n(\n.\f.\x.n(\g.\h.h(gf))(\u.x)(\u.u))m)nm)))((\n.\f.\x.f(nfx))n))  

9/3 is written as follows:

    (\n.((\f.(\x.xx)(\x.f(xx)))(\c.\n.\m.\f.\x.(\d.(\n.n(\x.(\a.\b.b))(\a.\b.a))d((\f.\x.x)fx)(f(cdmfx)))((\m.\n.n(\n.\f.\x.n(\g.\h.h(gf))(\u.x)(\u.u))m)nm)))((\n.\f.\x.f(nfx))n))(\f.\x.f(f(f(f(f(f(f(f(fx)))))))))(\f.\x.f(f(fx)))

Which evaluates to:

    \f.\x.f(f(f(x)))

