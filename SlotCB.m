


slot = get(gcbo, 'userdata');
currentPlayer = MakeMove(gcbo,gameBoard,slot,currentPlayer,player1,player2);

%get a list of the open slots on the board
openSlots = FindOpenSlots(gameBoard, false, false);

if ~strcmp(gameBoard.mode, 'human vs human') && numel(openSlots) ~= 0

    if strcmp(gameBoard.mode, 'easy')
        %pick random move
        slot = openSlots(randi(numel(openSlots)));

    elseif strcmp(gameBoard.mode, 'medium')
        %loops through each open slot and checks to see if it can produce a win
        %builds lists that contain all possible win spots and block spots
        %if none are found, pick a random open spot
        winningMoves = [];
        blockingMoves = [];
        for index = 1:numel(openSlots)
            [win, ~] = CheckForPosWinOrFork(gameBoard, openSlots(index), currentPlayer.value, 2);
            [block, ~] = CheckForPosWinOrFork(gameBoard, openSlots(index), -currentPlayer.value, 2);
            if win
                winningMoves(numel(winningMoves)+1) = openSlots(index);
            end
            if block
                blockingMoves(numel(blockingMoves)+1) = openSlots(index);
            end
        end
        if numel(winningMoves) ~= 0
            slot = winningMoves(1);
        elseif numel(blockingMoves) ~= 0
            slot = blockingMoves(1);
        else
            slot = openSlots(randi(numel(openSlots)));
        end

    else %expert
        [isPlayerInCorner, oppositeCorner] = CheckForCorner(gameBoard, -currentPlayer.value);
        isPlayerInCenter = CheckForCenter(gameBoard);
        [isPlayerInSide, sideSlot] = CheckForSides(gameBoard);

        winningMoves = [];
        blockingMoves = [];
        forkingMoves = [];
        blockForkMoves = [];
        for index = 1:numel(openSlots)
            [win, ~] = CheckForPosWinOrFork(gameBoard, openSlots(index), currentPlayer.value, 2);
            [block, ~] = CheckForPosWinOrFork(gameBoard, openSlots(index), -currentPlayer.value, 2);
            [~, fork] = CheckForPosWinOrFork(gameBoard, openSlots(index), currentPlayer.value, 1);
            [~, blockFork] = CheckForPosWinOrFork(gameBoard, openSlots(index), -currentPlayer.value, 1);
            if win
                winningMoves(numel(winningMoves)+1) = openSlots(index);
            end
            if block
                blockingMoves(numel(blockingMoves)+1) = openSlots(index);
            end
            if fork
                forkingMoves(numel(forkingMoves)+1) = openSlots(index);
            end
            if blockFork
                blockForkMoves(numel(blockForkMoves)+1) = openSlots(index);
            end
        end

        if numel(winningMoves) ~= 0
            %fprintf('win is possible, winning\n')
            slot = winningMoves(1);
        elseif numel(blockingMoves) ~= 0
            %fprintf('block is possible, blocking\n')
            slot = blockingMoves(1);
        elseif numel(forkingMoves) ~= 0
            %fprintf('fork possible, forking\n')
            slot = forkingMoves(1);
        elseif numel(blockForkMoves) == 1
            %fprintf('must block fork, blocking\n')
            slot = blockForkMoves(1);
        elseif numel(blockForkMoves) == 2
            openSides = FindOpenSlots(gameBoard, false, true);
            slot = openSides(1);
        elseif numel(blockForkMoves) == 4
            openCorners = FindOpenSlots(gameBoard, true, false);
            slot = openCorners(1);
        elseif ~isPlayerInCenter
            %fprintf('center is open, moving in center\n')
            slot = 5;
        elseif isPlayerInCorner
            %fprintf('player is in a corner, moving in opposite corner\n')
            slot = oppositeCorner;
        elseif ~isPlayerInCorner
            %fprintf('corners are open, moving in corner\n')
            slot = 1;
        elseif ~isPlayerInSide
            %fprintf('sides are open, moving in side\n')
            slot = sideSlot;
        end
    end
    currentPlayer = MakeMove(findobj('tag', ['Slot', num2str(slot)]),gameBoard,slot,currentPlayer,player1,player2);
end