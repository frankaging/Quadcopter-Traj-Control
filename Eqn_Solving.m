syms a b c d e f
x = 6;
A = a*x^5 + b*x^4 + c*x^3 + d*x^2 + e*x + f == 0.75;
B = 5*a*x^4 + 4*b*x^3 + 3*c*x^2 + 2*d*x + e + 0 == 0 ;
C = 20*a*x^3 + 12*b*x^2 + 6*c*x + 2*d + 0 + 0 == 0;

x = 8;
AA = a*x^5 + b*x^4 + c*x^3 + d*x^2 + e*x + f == 1;
BB = 5*a*x^4 + 4*b*x^3 + 3*c*x^2 + 2*d*x + e + 0 == 0; 
CC = 20*a*x^3 + 12*b*x^2 + 6*c*x + 2*d + 0 + 0 == 0;

S = solve([A, B, C, AA, BB, CC], [a b c d e f]);
r = [S.a S.b S.c S.d S.e S.f]