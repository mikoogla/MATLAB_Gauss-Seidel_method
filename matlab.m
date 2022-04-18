clc;

LICZBA_WEZLOW = 25;
WARTOSC_POCZATKOWA = 0;
V = ones(sqrt(LICZBA_WEZLOW)+2).* WARTOSC_POCZATKOWA;


rows = size(V, 1);
cols = size(V, 2);

V(1, :) =  500;
V(2:end-1, 1) = 300;
V(2:end-1, end) = 150;
V(end, :) = 0;
V_prev = V;

eps = 0.01;
max_iters = 10000;
condition = false;
while(max_iters > 0 && condition == false)
    for i=2 : rows-1
        for j=2 : cols-1
            V(i, j) = 0.25*(V(i, j-1) + V(i-1, j) + V_prev(i+1, j) + V_prev(i, j+1));
        end
    end
    
    condition = true;
    C = V(2:rows-1, 2:cols-1) - V_prev(2:rows-1, 2:cols-1);
    
    for i=1 : size(C, 1)
        for j=1 : size(C, 2)
            if abs(C(i, j)) > eps
                condition = false;
            end
        end
    end
    
max_iters = max_iters - 1;
V_prev = V;

    if condition == true
        disp("eps spelniony");
    end
    if max_iters <= 0
        disp("wyczerpany limit iteracji");
    end
end
output = contourf(flipud(V));
clabel(output);