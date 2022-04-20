function [x, y] = Yrok_4
  
  function [f] = RightParts(f, y, x)
    f(1) = atan(x^2 + y(2)^2);
    f(2) = sin(x + y(1));
  endfunction

  function [x, y, f] = RGK(n, x, y, f, h)
    tempY = zeros(n, 2);
    tempF = zeros(n, 4);
    [f] = RightParts(f, y, x);
    for i=1:n
      tempF(1,i) = h*f(i);
      tempY(i) = y(i) + tempF(1,i)/2;
    endfor
    x += h/2;
    [f] = RightParts(f, tempY, x);
    for i=1:n
      tempF(2,i) = h*f(i);
      tempY(i) = y(i) + tempF(2,i)/2;
    endfor
    [f] = RightParts(f, tempY, x);
    for i=1:n
      tempF(3,i) = h*f(i);
      tempY(i) = y(i) + tempF(3,i)/2;
    endfor
    x = x + h/2;
    [f] = RightParts(f, tempY, x);
    for i=1:n
      tempF(4,i) = h*f(i);
      y(i) += (tempF(1,i) + 2*tempF(2,i) + 2*tempF(3,i) + tempF(4,i))/6;
    endfor
  endfunction
  
  %%%%%%%%%%%%%%%%%%%%%
  n = 2; h = 0.1; f = zeros(2,1); y = [0.5,1.5]; Left = 0; Right = 2; 
  x = Left; steps = (Right-Left)/h; 
  Xi = zeros(steps, 1); Y1i = zeros(steps, 1); Y2i = zeros(steps, 1); k = 1;
  
  for i = 1:steps
    [x, y, f] = RGK(n, x, y, f, h);
    Xi(k) = x;
    Y1i(k) = y(1);
    Y2i(k) = y(2);
    k++;
  endfor
  
  subplot (2, 1, 1)
  plot (Xi, Y1i, 'p-p');
  title ("y1(x)");
  subplot (2, 1, 2)
  plot (Xi, Y2i, 'p-p');
  title ("y2(x)");
endfunction