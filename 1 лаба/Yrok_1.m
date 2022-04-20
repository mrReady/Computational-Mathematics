function [x0,k] = Yrok_1
  
  function [y] = BISECT(x)
    y = log(x) - 1/(1 + x^2); 
  endfunction

  a = 1; b = 3; eps = 5e-5; k = 0; x0 = 0;
  
  while (eps*2 < b - a)
    x0 = (a + b)*0.5;
    if BISECT(x0) > 0
      b = x0;
    else
      a = x0;
    endif
    k = k + 1;
  endwhile

endfunction
