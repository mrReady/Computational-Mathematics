function [intRECT, n1, intTRAP, n2, intSIMPS, n3] = Yrok_3
 
  function [y] = F(x)
    y = sin(x^2 + 2*x^3 + x^4); 
  endfunction
  
  function [s1] = RECT(h1, n1, x)
    s1 = 0;
    for i = 1:n1
      s1 = s1 + F(x(i) + h1/2);
    endfor
    s1 = s1*h1;
  endfunction

  function [s2] = TRAP(h2, n2, x)
    s2 = 0;
    for i = 1:(n2-1)
      s2 = s2 + F(x(i)) + F(x(i+1));
    endfor
    s2 = s2*h2/2;
  endfunction
  
    function [s3] = SIMPS(h3, n3, x)
    s3 = 0;
    for i = 1:(n3/2 - 0.5)
      s3 = s3 + F(x(2*i-1)) + 4*F(x(2*i)) + F(x(2*i+1));
    endfor
    s3 = s3*h3/3;
  endfunction
 
  %%%%%%%%%%%%%%%%%%%%%
  a = 0; b = 1; n = 2; h = (b - a)/n; eps = 0.01;
  n1 = n; n2 = n; n3 = n; h1 = h; h2 = h; h3 = h;
  rect1 = a; rect2 = b; trap2 = a; trap1 = b; simps1 = a; simps2 = b;
  for i = 1:n
    x(i) = a + i*h;
  endfor
  
  while (abs(rect1 - rect2)/3) > eps
    rect1 = RECT(h1, n1, x);
    n1 = n1*2;
    h1 = (b - a)/n1;
    for i = 1:n1
      x(i) = a + i*h1;
    endfor
    rect2 = RECT(h1, n1, x);
  endwhile
  intRECT = rect2 + (rect2 - rect1)/3;

while (abs(trap2 - trap1)/3) > eps
    trap1 = TRAP(h2, n2, x);
    n2 = n2*2;
    h2 = (b - a)/n2;
    for i = 1:n2
      x(i) = a + i*h2;
    endfor
    trap2 = TRAP(h2, n2, x);
  endwhile
  intTRAP = trap2 - (trap2 - trap1)/3;

while (abs(simps2 - simps1)/15) > eps
    simps1 = SIMPS(h3, n3, x);
    n3 = n3*2;
    h3 = (b - a)/n3;
    for i = 1:n3
      x(i) = a + i*h3;
    endfor
    simps2 = SIMPS(h3, n3, x);
  endwhile
  intSIMPS = simps2 - (simps2 - simps1)/15;
endfunction
