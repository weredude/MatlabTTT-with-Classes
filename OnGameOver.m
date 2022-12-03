



function[] = OnGameOver(board, isTie, currentPlayer)
    for index = 1:9
        set(findobj('tag', ['Slot', num2str(index)]), 'Enable', 'off');
    end
    RecordGame(board, isTie, currentPlayer);
    EndGame(board);
end