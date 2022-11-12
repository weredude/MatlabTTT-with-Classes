
for slotNum = 1:9
    set(findobj('tag', ['Slot',num2str(slotNum)]), 'Enable', 'on');
end

set(gcbo, 'Enable', 'off');