tamHist = 32;

test (1).Files = {'F04.jpg' 'F05.jpg' 'F06.jpg'};
test (2).Files = {'F10.jpg' 'F11.jpg' 'F12.jpg'};

clases = RecogTrainer (tamHist);
ConfusionMatrix = ConfMat (test, clases, tamHist);

ConfusionMatrix