



function[] = OnGameOver(board, isTie, currentPlayer)
    for index = 1:9
        set(findobj('tag', ['Slot', num2str(index)]), 'Enable', 'off');
    end
    RecordGame(board, isTie, currentPlayer);
    set(findobj('tag', 'winsTextST'), 'string', num2str(board.wins));
    set(findobj('tag', 'lossesTextST'), 'string', num2str(board.losses));
    set(findobj('tag', 'tiesTextST'), 'string', num2str(board.ties));
    EndGame(board);
end