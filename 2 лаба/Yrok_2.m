function [M, w, nf, R, Q] = Yrok_2(n)
 
  function [y] = f(x)
    y = 1000 /(x^2 - x*6 + 60); 
  endfunction
  
  function [y] = df(x, dn)
    switch dn
      case 1
        y = (2000*(3 - x))/(60 - 6*x + x^2)^2;
      case 2
        y = (6000*(-8 - 6*x + x^2))/(60 - 6*x + x^2)^3;
      case 3
        y = (24000*(3 - x)*(-42 - 6*x + x^2))/(60 - 6*x + x^2)^4;
      case 4
        y = (24000*(-1584 + 2520*x - 240*x^2 - 60*x^3 + 5*x^4))/...
        (60 - 6*x + x^2)^5;
      case 5
        y = (720000*(3456 + 1584*x - 1260*x^2 + 80*x^3 + 15*x^4 - x^5))/...
        (60 - 6*x + x^2)^6;
      case 6
        y = (720000*(219456 - 145152*x - 33264*x^2 + 17640*x^3 - 840*x^4 -...
        126*x^5 + 7*x^6))/(60 - 6*x + x^2)^7;
    endswitch
  endfunction
  
  function [s] = lagrang(x, y, t)
    ln = length(x);
    s = 0;
    for i = 1:ln
      p = 1;
        for j = 1:ln
          if (j ~= i)
            p = p*(t - x(j))/(x(i) - x(j));
          endif
        endfor
      s = s + y(i)*p;
    endfor
  endfunction

  %%%%%%%%%%%%%%%%%%%%%
  a = -1; b = 6; nf = 1; da = a;
  yw = 1:((b - a)/0.2 + 2); yw = diff(yw);
  
  xk = 1:(n + 1);
  %for k = 1:n
  %  xk(k) = (a + b)/2 + ((b - a)/2)*cos(pi*(2*k - 1)/(2*n));
  %endfor
  
  for i = 1:((b - a)/0.2 + 1)
    x(i) = a;
    a = a + 0.2;
    y(i) = f(x(i));
    ym(i) = df(x(i), n + 1);
    for j = 1:n
      yw(i) = yw(i)*(x(i) - xk(j));
    endfor
  endfor
  for i = 1:((b - da)/0.2 + 1)
    yl(i) = y(i) - lagrang(x, y, x(i));
  endfor
  M = max(abs(ym));
  w = max(abs(yw));
  for i = 1:n
    nf = nf*i;
  endfor
  R = max(abs(yl));
  Q = M*w/nf;
  for i = 1:(n + 1)
  %for i = 1:n
    rsl(i) = lagrang(x, y, xk(i));
  endfor
  plot(x, y, '-g;True f ;', xk, rsl, '*b;interpolation;',...
  xk, rsl, '-r;interpolation;');
  grid();
endfunction
