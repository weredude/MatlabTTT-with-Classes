
rng shuffle
mode = 'medium';
gameBoard = TTTBoard(mode);
player1 = GamePlayer(1,'X');
player2 = GamePlayer(-1, 'O');
currentPlayer = GamePlayer(player1.value, player1.letter);