
%Function takes as input the song you wish to analyze, running ICA on it to
%separate each frame into 3 independent tracks, then analyzing those frames
%in frequency to find peaks and hopefully notes in the extracted
%components.
%For visualization, the output matrix lengths contains one row for each
%frequency component found in the song, each column representing one frame
%(1/24th of a second) of the song. If a certain frequency is present for a
%certain number of frames it makes a chain, the total continuous length of
%that chain being recorded in 
function [lengths, allFreq] = main(song_name)

close all

numSources = 3;
overlap = 12;
timeSize = .5/overlap;
freqTheshold = 150;

the_song = strcat(song_name, '.wav');
song_name = strcat('../Music/', song_name, '.wav');
[Y,Fs] = wavread(song_name);
%downsample the data
duration = length(Y)/Fs; %in sec
%number of jadeR iterations
iter = floor(duration/timeSize);
usableDuration = iter*timeSize;
Y = Y(1:usableDuration*Fs);

%vector of the time divisions, in samples
times = round((0:usableDuration/iter:usableDuration)*Fs);
times(1) = 1;
tracker = zeros(numSources,iter);
freqMapping = zeros(numSources,1);
freqCounter = 1;
secTracker = zeros(numSources,iter);
secFreqMapping = zeros(numSources, 1);
secFreqCounter = 1;
iter = iter - overlap;
for i = 1:iter
    %sound data for this frame
    frameToAnalyze = Y(times(i):times(i+overlap));
    numrows = 20;
    numcols = floor(length(frameToAnalyze)/numrows);
    frameToAnalyze = frameToAnalyze(1:numrows*numcols);
    frameToAnalyze = reshape(frameToAnalyze,numrows,numcols);
    outputFrame = jadeR(frameToAnalyze, numSources);
    outputFrame = (outputFrame*frameToAnalyze)';
    resultFFT = abs(fft(outputFrame));
    freqRange = round(length(resultFFT)/2);
    resultFFT = resultFFT(1:freqRange,:);
    secMaxes = resultFFT;
    %contains max FFT value for each source for this iteration
    [amplitude, index] = max(resultFFT(1:freqRange,:),[],1);
    for j = 1:numSources
        if amplitude(j) > freqTheshold
            %if the frequency is already in our list, put it in the right
            %spot; if not, create a new row for it
            memberChecker = ismember(freqMapping, (index(j)-4):(index(j)+4));
            %if its already in our frequency vector, update right spot
            if sum(memberChecker) > 0
                if tracker(find(memberChecker,1), i) > amplitude(j)
                    
                else
                    tracker(find(memberChecker,1), i) = amplitude(j);
                end
            else %if this is a new frequency, set map and insert
                freqMapping(freqCounter) = index(j);
                tracker(freqCounter,i) = amplitude(j);
                freqCounter = freqCounter + 1;
            end
            if index(j)+10 < length(secMaxes)
                secMaxes(abs(index(j)-10)+1:index(j)+10,j) = 0;
            else
                secMaxes(abs(index(j)-10)+1:end,j) = 0;
            end
            [secAmplitude, secIndex] = max(secMaxes(1:freqRange,:),[],1);
            if secAmplitude(j) > freqTheshold
                secMemberChecker = ismember(secFreqMapping, (secIndex(j)-4):(secIndex(j)+4));
                if sum(secMemberChecker) > 0
                    if secTracker(find(secMemberChecker,1), i) > secAmplitude(j)

                    else
                        secTracker(find(secMemberChecker,1),i) = secAmplitude(j);
                    end
                else
                    secFreqMapping(secFreqCounter) = secIndex(j);
                    secTracker(secFreqCounter,i) = secAmplitude(j);
                    secFreqCounter = secFreqCounter +1;
                end
            end
        end
    end
end

%now to plot tracker with corresponding frequencies
boolTracker = ismember(tracker,0:max(max(tracker))); %convert to 1s and 0s
boolTracker = not(boolTracker);

secboolTracker = ismember(secTracker,0:max(max(secTracker))); %convert to 1s and 0s
secboolTracker = not(secboolTracker);

%sort both trackers and their freq vectors to merge easier
%sort freq vector ascendingly, then mirror that on tracker data

%do this for first set of max values
[sortedFreq, indexSwaps] = sort(freqMapping);
tempBool = zeros(size(tracker));
tempTracker = zeros(size(tracker));
for i = 1:length(indexSwaps)
    tempBool(i,:) = boolTracker(indexSwaps(i),:);
    tempTracker(i,:) = tracker(indexSwaps(i),:);
end
boolTracker = tempBool;
tracker = tempTracker;

%and again for the secondary ones
[secSortedFreq, secIndexSwaps] = sort(secFreqMapping);
tempBool = zeros(size(secTracker));
tempTracker = zeros(size(secTracker));
for i = 1:length(secIndexSwaps)
    tempBool(i,:) = secboolTracker(secIndexSwaps(i),:);
    tempTracker(i,:) = secTracker(secIndexSwaps(i),:);
end
secboolTracker = tempBool;
secTracker = tempTracker;

%Merge the two boolTrackers together so that it becomes one continuous
%matrix
%First, find how many distinct frequency components there are
distinct = length(ismember(sortedFreq,secSortedFreq));
distinct = distinct + length(ismember(secSortedFreq,sortedFreq));
distinct = distinct - sum(ismember(sortedFreq,secSortedFreq));
allboolTracker = zeros(distinct,length(tracker));
allTracker = zeros(distinct,length(tracker));
allFreq = zeros(distinct,1);
sortedCopy = sortedFreq;
secCopy = secSortedFreq;

%next, sequentially add in minimum frequency of my vectors to the "all"
%matrices
for i = 1:distinct
    %add in data from first copy if its frequency is next
    if (length(sortedCopy) > 0) && (length(secCopy) > 0)
        if sortedCopy(1) < secCopy(1)
            allFreq(i) = sortedCopy(1);
            allboolTracker(i,:) = boolTracker(1,:);
            allTracker(i,:) = tracker(1,:);
            sortedCopy(1) = [];
            boolTracker(1,:) = [];
            tracker(1,:) = [];
        elseif secCopy(1) < sortedCopy(1)
            allFreq(i) = secCopy(1);
            allboolTracker(i,:) = secboolTracker(1,:);
            allTracker(i,:) = secTracker(1,:);
            secCopy(1) = [];
            secboolTracker(1,:) = [];
            secTracker(1,:) = [];
            %if they're the same freq value, remove both and add in average
        else
            allFreq(i) = sortedCopy(1);
            sortedCopy(1) = [];
            secCopy(1) = [];

            %
            temp = boolTracker(1,:) + secboolTracker(1,:);
            temp(temp == 2) = 1;
            allboolTracker(i,:) = temp;
            boolTracker(1,:) = [];
            secboolTracker(1,:) = [];
            allTracker(i,:) = tracker(1,:);
            tracker(1,:) = [];


            secTracker(1,:) = [];
        end
    elseif length(sortedCopy) == 0
        allFreq(i) = secCopy(1);
        allboolTracker(i,:) = secboolTracker(1,:);
        allTracker(i,:) = secTracker(1,:);
        secCopy(1) = [];
    else
        allFreq(i) = sortedCopy(1);
        allboolTracker(i,:) = boolTracker(1,:);
        allTracker(i,:) = tracker(1,:);
        sortedCopy(1) = [];
    end
end
%now, combined values are in allFreq, allTracker, and allboolTracker

%delete chains of values that fall below some chain threshold
allboolTracker = findChains(allboolTracker, 5);

%REMOVE EMPTY ROWS AFTER FINDING ONLY CHAINS
rowsToDel = find(sum(allboolTracker,2)==0);
allboolTracker(rowsToDel,:) = [];
allTracker(rowsToDel,:) = [];
allFreq(rowsToDel) = [];
allTracker = allTracker.*allboolTracker;

lengths = convertToLengths(allboolTracker);
%write this to a test file
%dlmwrite('dataMatrix.txt',allboolTracker,'delimiter',' ','newline','pc');
dlmwrite('freqVector.txt',allFreq','delimiter',' ','newline','pc');
movefile('freqVector.txt','../Visualizer/data/');
%dlmwrite('beatTimes.txt',beats,'delimiter',' ','newline','pc');
dlmwrite('dataMatrix.txt',lengths,'delimiter',' ','newline','pc');
movefile('dataMatrix.txt','../Visualizer/data/');
copyfile(song_name,'./');
movefile(the_song, 'song.wav');
copyfile('song.wav','../Visualizer/data/');
delete('song.wav');

%Plots of the data notes found.
% figure
% hold on
% for i = 1:size(allboolTracker,1)
%     scatter(times(1:end-1), allboolTracker(i,:)*allFreq(i),60);
% end
% title ('Relevant Frequency Values After ICA','FontSize',18);
% xlabel ('Time (samples)','FontSize',14);
% ylabel ('Frequency (Hz)','FontSize',14);




