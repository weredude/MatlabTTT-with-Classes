
rng shuffle
mode = 'medium';%'easy' 'medium' 'expert' or 'hVh'
first2Move = 'computer';%'computer' or 'human'
gameBoard = TTTBoard(mode, first2Move);
player1 = GamePlayer(1,'X');
player2 = GamePlayer(-1, 'O');
currentPlayer = GamePlayer(player1.value, player1.letter);