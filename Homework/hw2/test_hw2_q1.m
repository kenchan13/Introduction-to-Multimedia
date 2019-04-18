A=ones(100000,1)*.9;
A(500:10000,:) = .1;
gong = audioplayer(A, 44100);
play(gong);