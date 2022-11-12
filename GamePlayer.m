

classdef GamePlayer
    properties
        value
        letter
    end
    methods
        function self = GamePlayer(value, letter)
            self.value = value;
            self.letter = letter;
        end
    end
end