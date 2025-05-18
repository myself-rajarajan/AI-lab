% GCD of two numbers
gcd(A, 0, A) :- A > 0.
gcd(A, B, G) :-
    B > 0,
    R is A mod B,
    gcd(B, R, G).
