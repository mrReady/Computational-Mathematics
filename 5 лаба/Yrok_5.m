function [Xi,Yi,S] = Yrok_5
  
  n = 20;
  Left = -2;
  Right = 2;
  f = @(x) (e^x - cos(x))(cos(x + x^2));
  x = zeros(1, n + 1);
  y = zeros(1, n + 1);

  function [x, y, step] = CountFunction(f, x, y, Left, Right, n)
    step = (Right-Left)n;
    k = 1;
    for i = LeftstepRight
      x(k) = i;
      y(k) = f(i);
      k++;
    endfor
  endfunction
 
  function [S, Xi, Yi, h, F, m] = Spline(x, y, n, step, Left, f)
    F = zeros(1, n + 1);
    h = gallery(tridiag, n + 1, 12, 2, 12);
    h(1, 2) = 1;
    h(n+1, n) = 1;
    for i = 2n
      F(i) = 3(((y(i+1) - y(i))2) - ((y(i) - y(i-1))2));
    endfor
    m = Fh;
    for i = 1n
      X = Left + step2 + step(i-1);
      Xi(i) = X;
      t = (X - x(i))step;
      Yi(i) = f(X);
      S(i) = y(i)(1-t)^2(1+2t) + y(i+1)t^2(3-2t) + m(i)stept(1-t)^2 ...
      - m(i+1)t^2(1+t)step;
    endfor
  endfunction

  [x, y, step] = CountFunction(f, x, y, Left, Right, n);
  [S, Xi, Yi, h, F, m] = Spline(x, y, n, step, Left, f);

  subplot (2, 1, 1)
  plot (Xi, Yi, 'p-b');
  hold on;
  plot (Xi, S, 'p-g');
  hold off;
  title (f(x), S(x));
  subplot (2, 1, 2)
  plot (Xi(12), Yi(12), 'p-g');
  hold on;
  plot (Xi(12), S(12), 'p-b');
  hold off;
  title (f(x), S(x));
endfunction