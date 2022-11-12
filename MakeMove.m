

function[currentPlayer] = MakeMove(obj, board, slot, currentPlayer, player1, player2)
    AddMoveToBoard(board, slot, currentPlayer);
    gameOver = CheckGameOver(board);
    set(obj, 'string', currentPlayer.letter, 'Enable', 'off');

    if gameOver
        for index = 1:9
            set(findobj('tag', ['Slot', num2str(index)]), 'Enable', 'off');
        end
        board.ClearOpenSpots();
    end

    if currentPlayer.value == player1.value
        currentPlayer.value = player2.value;
        currentPlayer.letter = player2.letter;
    else
        currentPlayer.value = player1.value;
        currentPlayer.letter = player1.letter;
    end
end