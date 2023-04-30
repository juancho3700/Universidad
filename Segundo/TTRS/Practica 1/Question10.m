uniforme = rand (1,10000);
uniforme = uniforme .*2 - 1;
histogram (uniforme)

normal1 = randn (1,10000);
normal1 = sqrt (3).* normal1;
histogram (normal1)

normal2 = randn (1, 10000);
normal2 = normal2 + 5;
histogram (normal2)