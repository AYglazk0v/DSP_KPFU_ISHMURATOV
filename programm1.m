%% Очистка рабочеко пространства
clear "all"
clc

%% Чтение данных из файла
fid = fopen('~/COS/file/filekr2.dat');  %Открытие файлового дескриптора
A = fread(fid, inf, 'single');          %Чтение данных из файлового дескр.
fid = fclose("all");                    %Закрытие файлового дескр.

B = A;

Fs = 2000;              %частота дискрретизации
T = 1/Fs;               %Период дискретизации     
L = 500;                %Длительность сигнала
t = (0:L-1)*T;          %Временной вектор


%% Полосовой фильтр (выделяем канал)

order    = 3; 
fcutlow  = 184;          %Нижняя частота пропускания
fcuthigh = 216;          %Верхняя частота пропускания
[b, a] = butter(order, [fcutlow, fcuthigh] / (Fs/2), 'bandpass');
B = filter(b, a, B);

%% Импульсная характеристика
h = zeros(65,1);

for i = -31:33
    if (i == 0)
        h(i + 32) = 2 * fcuthigh * fcutlow / Fs * (1 / fcutlow - 1 / fcuthigh);
    else
        h(i + 32) = 1 / (pi * i) * (sin(pi * i * fcuthigh * 2 / Fs) - sin(pi * i * fcutlow * 2 / Fs));
    end
end

h = h/max(h);

i = 1:65;

%% Построение графиков
tiledlayout(3,1);

nexttile;
plot(t,A);              %Построение исходных данных
title('Исходный сигнал');
xlabel('t');
ylabel('U(t)');

nexttile;
stem(i,h);
title('Отсчеты импульсной характеристики h(i). Порядок фильтра M = 65');
xlabel('i');
ylabel('H(i)');

nexttile;
plot(t,B),grid;              %Результата фильтрации
title('Цифровой фильтр');
xlabel('t');
ylabel('U(t)');