

function slot = FindNextMove(board, value)
    if board.mode == 'medium'
        win = board.CheckForWin(value);
        block = board.CheckForWin(-value);
        if win
            %find winning slot
            
        elseif block
            %find blocking slot
        else
            openSlots = board.FindOpenSlots();
            slot = openSlots(randi(numel(slots)));
        end
    end