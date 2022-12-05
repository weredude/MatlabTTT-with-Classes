


classdef TTTBoard < handle
    properties
        board;
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
            self.wins = wins;
            self.losses = losses;
            self.ties = ties;
            self.turn = 0;
        end

        function[winOrBlock, forkOrBlockFork] = CheckForPosWinOrFork(self, slot, value, winReq)
            [index1, index2] = Slot2Indices(self, slot);

            possibleOptions = 0;
            winOrBlock = false;
            forkOrBlockFork = false;
            rowSums = sum(self.board,2);
            columnSums = sum(self.board);
            if rowSums(index1) == value*winReq
                winOrBlock = true;
                possibleOptions = possibleOptions+1;
            end
            if columnSums(index2) == value*winReq
                winOrBlock = true;
                possibleOptions = possibleOptions+1;
            end
            if index1 == index2
                [diagSum1, ~] = SumDiagonals(self);
                if diagSum1 == value*winReq
                    winOrBlock = true;
                    possibleOptions = possibleOptions+1;
                end
            end

            if (index1 == 1 && index2 == 3) || (index1 == 2 && index2 == 2) || (index1 == 3 && index2 == 1)
                [~, diagSum2] = SumDiagonals(self);
                if diagSum2 == value*winReq
                    winOrBlock = true;
                    possibleOptions = possibleOptions+1;
                end
            end
            if possibleOptions > 1
                forkOrBlockFork = true;
            end
        end

        function slots = FindOpenSlots(self, onlyCorners, onlySides)
            slots = [];
            modBoard = self.board';
            for index = 1:numel(modBoard)
                if onlyCorners
                    if modBoard(index) == 0 && rem(index,2) ~= 0
                        slots(numel(slots)+1) = index;
                    end
                elseif onlySides
                    if modBoard(index) == 0 && rem(index,2) == 0
                        slots(numel(slots)+1) = index;
                    end
                else
                    if modBoard(index) == 0
                        slots(numel(slots)+1) = index;
                    end
                end
            end
        end

        function self = AddMoveToBoard(self, slot, player)

            [index1, index2] = Slot2Indices(self, slot);
            
            self.board(index1, index2) = player.value;
            self.turn = self.turn + 1;
        end

        function [isPlayerInCenter] = CheckForCenter(self)
            if self.board(2,2) == 0
                isPlayerInCenter = false;
            else
                isPlayerInCenter = true;
            end
        end

        function [isPlayerInCorner, slot] = CheckForCorner(self, value)
            corners = [self.board(1,1), self.board(1,3), self.board(3,1), self.board(3,3)];
            if any(corners)
                isPlayerInCorner = true;
                if corners(1) == value
                    slot = 9;
                elseif corners(2) == value
                    slot = 7;
                elseif corners(3) == value
                    slot = 3;
                elseif corners(4) == value
                    slot = 1;
                else
                    slot = 0;
                end
            else
                isPlayerInCorner = false;
                slot = 0;
            end
        end

        function [isPlayerInSide, slot] = CheckForSides(self)
            sides = [self.board(1,2), self.board(2,1), self.board(2,3), self.board(3,2)];
            if ~all(sides)
                isPlayerInSide = false;
                slot = 2;
            else
                isPlayerInSide = true;
                slot = 0;
            end
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

        function [diagSum1, diagSum2] = SumDiagonals(self)
            diagSum1 = 0;
            diagSum2 = 0;
            for index = 1:3
                diagSum1 = diagSum1+self.board(index,index);
                diagSum2 = diagSum2+self.board(index,4-index);
            end
        end

        function [index1, index2] = Slot2Indices(self, slot)
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
        end

        function [gameOver, tie] = CheckGameOver(self, value)
            rowSums = sum(self.board, 2);
            columnSums = sum(self.board);
            [diagSums(1), diagSums(2)] = SumDiagonals(self);

            win = ismember(value*3, rowSums) || ismember(value*3, columnSums) || ismember(value*3, diagSums); 
            tie = self.turn == 9 && ~win;
            if win || tie
                gameOver = true;
            else
                gameOver = false;
            end
        end

        function self = EndGame(self)
            self.board = ones(3,3);
        end
    end
end