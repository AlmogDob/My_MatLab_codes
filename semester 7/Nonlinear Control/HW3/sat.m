function [outputArg1] = sat(v)

if norm(v) < 1
    outputArg1 = v;
else
    outputArg1 = sign(v);
end

