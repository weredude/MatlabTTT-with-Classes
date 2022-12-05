
for slotNum = 1:9
    set(findobj('tag', ['Slot',num2str(slotNum)]), 'Enable', 'on');
end

set(gcbo, 'Enable', 'off');

if strcmp(gameBoard.first2Move, 'computer')
    if ~strcmp(gameBoard.mode, 'expert')
        openSlots = FindOpenSlots(gameBoard, false, false);
        slot = openSlots(randi(numel(openSlots)));
    else%expert
        slot = 5;
    end
    currentPlayer = MakeMove(findobj('tag', ['Slot', num2str(slot)]),gameBoard,slot,currentPlayer,player1,player2);
end