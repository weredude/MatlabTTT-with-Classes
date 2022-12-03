


classdef TTTBoard < handle
    properties
        board;
        filledRows;
        filledColumns;
        filledDiagonals;
        turn;
        mode;
        first2Move;
        wins;
        losses;
        ties;
    end
    methods
        function self = TTTBoard(mode, first2Move, wins, losses, ties)
            self.mode = mode;
            self.first2Move = first2Move;
            self.board = zeros(3,3);
            self.filledRows = zeros(1,3);
            self.filledColumns = zeros(1,3);
            self.filledDiagonals = zeros(1,2);
            self.wins = wins;
            self.losses = losses;
            self.ties = ties;
            self.turn = 0;
        end
        function self = EndGame(self)
            self.board = ones(3,3);
        end
        function self = RecordGame(self, isTie, currentPlayer)
            if isTie
                self.ties = self.ties+1;
            elseif currentPlayer.isPlayer
                self.wins = self.wins+1;
            else
                self.losses = self.losses+1;
            end
        end
        function self = AddMoveToBoard(self, slot, player)
            if slot <= 3
                index1 = 1;
                index2 = slot;
            elseif slot <= 6
                index1 = 2;
                index2 = slot-3;
            else
                index1 = 3;
                index2 = slot-6;
            end
            
            self.board(index1, index2) = player.value;

            self.filledRows(index1) = self.filledRows(index1) + player.value;
            self.filledColumns(index2) = self.filledColumns(index2) + player.value;
            if index1 == index2
                self.filledDiagonals(1) = self.filledDiagonals(1) + player.value;
            end
            if index1 + index2 == 4
                self.filledDiagonals(2) = self.filledDiagonals(2) + player.value;
            end
            self.turn = self.turn + 1;
        end
        function[winOrBlock, slot] = CheckForPosWin(self, value)
            %look for a win or a block
            rIndex = find(self.filledRows == 2*value);
            cIndex = find(self.filledColumns == 2*value);
            if rIndex
                %if a row has a possible win, look for the 0 and get the index
                index1 = rIndex;
                index2 = find(self.board(rIndex,:)==0);
                winOrBlock = true;
            elseif cIndex
                %if a column has a possible win, look for the 0 and get the index
                index1 = find(self.board(:,cIndex)==0);
                index2 = cIndex;
                winOrBlock = true;
            elseif self.filledDiagonals(1) == 2*value
                %if a diagonal has a win, check each spot for a 0 and get the
                %index
                for index = 1:3
                    if self.board(index,index) == 0
                        index1 = index;
                        index2 = index;
                        winOrBlock = true;
                    end
                end
            elseif self.filledDiagonals(2) == 2*value
                for index = 1:3
                    if self.board(index,size(self.board,1)+1-index) == 0
                        index1 = index;
                        index2 = size(self.board,1)+1-index;
                        winOrBlock = true;
                    end
                end
            else
                index1 = 0;
                index2 = 0;
                winOrBlock = false;
            end
            slot = index2 + 3*(index1-1);
        end
        function [gameOver, tie] = CheckGameOver(self)
            win = ismember(3, abs(self.filledRows)) | ismember(3, abs(self.filledColumns)) | ismember(3, abs(self.filledDiagonals));
            tie = self.turn == 9 && ~win;
            if win || tie
                gameOver = true;
            else
                gameOver = false;
            end
        end
        function slots = FindOpenSlots(self)
            slots = [];
            modBoard = self.board';
            for index = 1:numel(modBoard)
                if modBoard(index) == 0
                    slots(numel(slots)+1) = index;
                end
            end
        end
    end
end