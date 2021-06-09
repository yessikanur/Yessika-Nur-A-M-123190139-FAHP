namaAtlet = {'Jirjat' 'Sibi' 'Adi' 'Rijal'};
data = [9 15 8
        7 17 4
        8 16 3
        5 12 2];

maxJumlahTendangan = 10;
maxJarak = 20;
maxTendanganGoal = 10;

data(:,1)=data(:,1)/maxJumlahTendangan;
data(:,2)=data(:,2)/maxJarak;
data(:,3)=data(:,3)/maxTendanganGoal;

relasiAntarKriteria = [1 2 4
                       0 1 2
                       0 0 1];

TFN = {[-100/3 0      100/3]  [3/100 0     -3/100]
       [0      100/3  200/3]  [3/200 3/100 0     ]
       [100/3  200/3  300/3]  [3/300 3/200 3/100 ]
       [200/3  300/3  400/3]  [3/400 3/300 3/200 ]};
  
[RasioKonsistensi] = HitungKonsistensi(relasiAntarKriteria);

if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = CodeFuzzyAHP(relasiAntarKriteria, TFN); 
    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria'; 
    
    disp('=======================================')
    disp('Nama Atlet     Skor        Hasil       ')
    disp('=======================================')
end

for i = 1:size(ahp, 1)
    if ahp(i) < 0.6
        status = 'Kurang';
    elseif ahp(i) < 0.7
        status = 'Cukup';
    elseif ahp(i) < 0.8
        status = 'Baik';
    else
        status = 'Sangat Baik';
    end
 
    disp([char(namaAtlet(i)), blanks(13 - cellfun('length',namaAtlet(i))), '  ', ...
        num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), '  ', ...
        char(status)])
end