function boolTracker = findChains(boolTracker, chainLength)

%remove freq values where chains of occurences are length chainLength or less
filter = ones(chainLength,1);
%for each row
for row = 1:size(boolTracker,1)
    %loop through data, add values as you go
    thisRow = zeros(1,size(boolTracker,2)-(chainLength-1));
    for col = 1:size(boolTracker,2)-(chainLength-1)
        %slide along each row, adding up values as you go
        thisRow(col) = boolTracker(row,col:col+(chainLength-1))*filter;
    end
    thisRow(thisRow < chainLength) = 0;
    %loop back through, putting back in values where appropriate
    %chainLengths occur
    boolTracker(row,:) = 0;
    for col = 1:length(thisRow)
        if(thisRow(col) == chainLength)
            boolTracker(row,col:col+(chainLength-1)) = filter';
        end
    end
end
