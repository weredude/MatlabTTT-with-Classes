

classdef GamePlayer
    properties
        value
        letter
        isPlayer
    end
    methods
        function self = GamePlayer(value, letter, isPlayer)
            self.value = value;
            self.letter = letter;
            self.isPlayer = isPlayer;
        end
    end
end