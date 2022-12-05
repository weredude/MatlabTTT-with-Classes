clear
rng shuffle

set(findobj('tag','ModeSelectPM'),'enable','on');
set(findobj('tag','FirstMoveTx'),'enable','off');
set(findobj('tag','FirstMovePM'),'enable','off');
set(findobj('tag','StartGamePB'),'enable','on');
set(findobj('tag','Name1Tx'),'enable','on');
set(findobj('tag','Name1EB'),'enable','on');
set(findobj('tag','Name2Tx'),'enable','on');
set(findobj('tag','Name2EB'),'enable','on');

name1='';
name2='';
modeIndex=1;
mode = 'hVh';
first2Move = 'human';
wins=0;
losses=0;
ties=0;
