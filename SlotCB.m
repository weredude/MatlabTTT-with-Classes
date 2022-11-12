


slot = get(gcbo, 'userdata');
currentPlayer = MakeMove(gcbo,gameBoard,slot,currentPlayer,player1,player2);

openSlots = FindOpenSlots(gameBoard);
if ~strcmp(gameBoard.mode, 'hVh') && numel(openSlots) ~= 0
    if strcmp(gameBoard.mode, 'easy')
        openSlots = FindOpenSlots(gameBoard);
        slot = openSlots(randi(numel(openSlots)));
    elseif strcmp(gameBoard.mode, 'medium')
        [win, winSlot] = CheckForPosWin(gameBoard, currentPlayer.value);
        [block, blockSlot] = CheckForPosWin(gameBoard, -currentPlayer.value);
        if win
            slot = winSlot;
        elseif block
            slot = blockSlot;
        else
            slot = openSlots(randi(numel(openSlots)));
        end
    else
        %expert
    end
    currentPlayer = MakeMove(findobj('tag', ['Slot', num2str(slot)]),gameBoard,slot,currentPlayer,player1,player2);
end
