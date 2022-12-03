


slot = get(gcbo, 'userdata');
currentPlayer = MakeMove(gcbo,gameBoard,slot,currentPlayer,player1,player2);

%get a list of the open slots on the board
openSlots = FindOpenSlots(gameBoard);
if ~strcmp(gameBoard.mode, 'hVh') && numel(openSlots) ~= 0
    if strcmp(gameBoard.mode, 'easy')
        %pick random move
        slot = openSlots(randi(numel(openSlots)));
    elseif strcmp(gameBoard.mode, 'medium')
        %check for wins and blocks
        [win, winSlot] = CheckForPosWin(gameBoard, currentPlayer.value);
        [block, blockSlot] = CheckForPosWin(gameBoard, -currentPlayer.value);
        if win
            slot = winSlot;
        elseif block
            slot = blockSlot;
        %otherwise pick random move
        else
            slot = openSlots(randi(numel(openSlots)));
        end
    else
        %expert
    end
    currentPlayer = MakeMove(findobj('tag', ['Slot', num2str(slot)]),gameBoard,slot,currentPlayer,player1,player2);
end