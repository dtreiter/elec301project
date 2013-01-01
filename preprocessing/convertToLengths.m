function out = convertToLengths(in)

%loop through each row in matrix, starting a new loop to find how long it
%goes on once it hits a one
out = zeros(size(in));
zeroPad = zeros(size(in,1),1);
in(:,end+1) = zeroPad;

for row = 1:size(in,1)
    for col = 1:size(in,2)
        if in(row,col) == 1
            counter = 1;
            while in(row,col+counter) == 1
                counter = counter + 1;
            end
            out(row,col) = counter;
        end
    end
end

for row = 1:size(out,1)
    for col = size(out,2):-1:2
        if out(row,col) == out(row,col-1) - 1
            out(row,col) = 0;
        end
    end
end
        