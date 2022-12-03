
rng shuffle
mode = 'medium';%'easy' 'medium' 'expert' or 'hVh'
first2Move = 'human';%'computer' or 'human'

gameBoard = TTTBoard(mode, first2Move, wins, losses, ties);

if strcmp(first2Move, 'human')
    player1 = GamePlayer(1,'X',true);
    player2 = GamePlayer(-1,'O',false);
    currentPlayer = GamePlayer(player1.value, player1.letter, true);
else
    player1 = GamePlayer(1,'X',false);
    player2 = GamePlayer(-1, 'O',true);
    currentPlayer = GamePlayer(player1.value, player1.letter, false);
end

set(findobj('tag', 'winsTextST'), 'string', num2str(wins));
set(findobj('tag', 'lossesTextST'), 'string', num2str(losses));
set(findobj('tag', 'tiesTextST'), 'string', num2str(ties));
set(findobj('tag', 'modeTextST'), 'string', mode);