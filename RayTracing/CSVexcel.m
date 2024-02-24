function [wallxyz1,wallxyz2,wallX,wallY] = CSVexcel
[fileName,fileAddress] = uigetfile('*.csv'); % Return [file name, file address].
[~,~,pointData] = xlsread([fileAddress,fileName]); % returns [num, txt, raw], meaning only numbers, text, all the file.
% pointData
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointData is a cell matrix. Every "cell" contains the information
% wether it is a number, text or a symbol.

%%
% strtok returns a string from left to right until delimitations.
% indicated here by ';'. The rest is inserted inside a 'remainer'. 
% str2num converts a matrix of characters to a numerical matrix. 
for i = 1:numel(pointData) % Numel returns the number of elements in the pointData matrix
    X(i,1) = str2num(strtok(pointData{i,1},';')); % Vertical matrix (abscissa x)
    [~,remain{i,1}] = strtok(pointData{i,1},';');
    Y(i,1) = str2num(strtok(remain{i},';')); % Vertical matrix (ordinate y)
end
%% 
wallxyz1 = zeros(size(X,1)/2,2); % Generates a matrix [number of lines from X/2,3]
wallxyz2 = wallxyz1;
% Defining walls clockwise
for i = 1:numel(X)/2 % Returns the 4 corners of a wall. Every line
    wallxyz1(i,:) = [X((i*2)-1,1),Y((i*2)-1,1)]; % Takes the coordonate of the initial points.
    wallxyz2(i,:) = [X(i*2,1),Y(i*2,1)]; % Takes the coordonate of the initial points. 
end
% wallxyz1
% wallxyz2

%%
wallX = [wallxyz1(:,1)';wallxyz2(:,1)']; % Line 1 = x ; Line 2 = y initial points. (Look Excel file)
wallY = [wallxyz1(:,2)';wallxyz2(:,2)']; 