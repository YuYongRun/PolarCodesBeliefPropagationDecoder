function z = f(x, y)
z = 0.9375*sign(x)*sign(y)*min(abs(x), abs(y));
end
