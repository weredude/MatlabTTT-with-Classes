

function[currentPlayer] = MakeMove(obj, board, slot, currentPlayer, player1, player2)
    AddMoveToBoard(board, slot, currentPlayer);
    set(obj, 'string', currentPlayer.letter, 'Enable', 'off');
    
    [gameOver, isTie] = CheckGameOver(board, currentPlayer.value);
    if gameOver
        OnGameOver(board, isTie, currentPlayer);
    else
        %switch current player after each move
        if currentPlayer.value == player1.value
            currentPlayer.value = player2.value;
            currentPlayer.letter = player2.letter;
            currentPlayer.isPlayer = player2.isPlayer;
        else
            currentPlayer.value = player1.value;
            currentPlayer.letter = player1.letter;
            currentPlayer.isPlayer = player1.isPlayer;
        end
    end
end