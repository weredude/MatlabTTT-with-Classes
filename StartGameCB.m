

first2MoveIndex = get(findobj('tag', 'FirstMovePM'), 'value');
switch first2MoveIndex
    case 1
		first2Move = 'human';
	case 2
		first2Move = 'computer';
end
switch modeIndex
    case 1
		mode = 'human vs human';
	case 2
		mode = 'easy';
		name2 = 'NA';
	case 3
		mode = 'medium';
		name2 = 'NA';
	case 4
		mode = 'expert';
		name2 = 'NA';
end

close;
openfig('TTTmain.fig');
