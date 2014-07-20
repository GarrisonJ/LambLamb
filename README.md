# Lambda Calculus:
  \ or λ  Denotes lambda  
  .       Denotes dot  
  ()      Denotes order  
  a-z     Denotes names  

# Examples:  

\x.x            # unit  
\sz.z           # Zero  
\sz.s(z)        # One  
\sz.s(s(z))     # Two  
\sz.s(s(s(z)))  # Three  
\xy.x           # True  
\xy.y           # False  

# Addition  

(\w.(\y.(\x.y(wyx))))  

# Multiplication  

(\x.(\y.(\z.x(yz))))  

# Division  

(\n.((\f.(\x.xx)(\x.f(xx)))(\c.\n.\m.\f.\x.(\d.(\n.n(\x.(\a.\b.b))(\a.\b.a))d((\f.\x.x)fx)(f(cdmfx)))((\m.\n.n(\n.\f.\x.n(\g.\h.h(gf))(\u.x)(\u.u))m)nm)))((\n.\f.\x.f(nfx))n))  
