syms P B

eqn = B*P-tan(B)*(P-B^2) == 0
eqn = B*cot(B)-1+(B^2)/P == 0
solve(eqn, B)