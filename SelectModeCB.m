


modeIndex=get(findobj('tag','ModeSelectPM'),'value');
if modeIndex ~= 1
   set(findobj('tag','FirstMoveTx'),'enable','on');
   set(findobj('tag','FirstMovePM'),'enable','on');
   set(findobj('tag','Name2Tx'),'enable','off');
   set(findobj('tag','Name2EB'),'enable','off');
else
   set(findobj('tag','FirstMoveTx'),'enable','off');
   set(findobj('tag','FirstMovePM'),'enable','off');
   set(findobj('tag','Name2Tx'),'enable','on');
   set(findobj('tag','Name2EB'),'enable','on');
end
