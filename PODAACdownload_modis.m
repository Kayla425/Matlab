% Last edited 10.01.15 KF
%
% Download files from HITIDE PODAAC'
% Currently, downloading MODIS Aqua
%
% % % % % % % % % % % % % % % % % % % % % %
%
% This script is useful, because the website is slow.
% Also, you may click to download the data
% you want, but it actually doesn't download, 
% so it takes multiple tries. It's a pain.
% So this script eliminates that and tries to
% download the data up to 1000 times.
%
% % % % % % % % % % % % % % % % % % % % % %
%
% EDIT:
%
InputFileName = 'modisPTC2014.txt';
InstrumentName = 'MODISAqua';
OutputDirName = '/Volumes/LaCie_Secondary/data/modis/aqua/sst/ptc/2014/Matlab/';
%
%
% % % % % % % % % % % % % % % % % % % % % %
% 
% ---------------SCRIPT-------------------%
%
[fileID,message] = fopen(InputFileName); %Amsre2011
http = textscan(fileID,'%s');
http = cat(2,http{:});

for ff = 1:length(http)%77
    % Create filename
    s1 = IntrumentName;
    s2 = http{ff,1}(97:104); % date
    s3 = http{ff,1}(127:135); % r number AMSRE (127:135)(135:140)
    filename{ff} = [OutputDirName,strcat(s1,s2,s3),'.nc'];
          
    if exist(filename{ff},'file') == 2
        continue
    end
    
    count = 0;
    err_count = 0;
    while count == err_count
        try
            urlwrite(http{ff,1},filename{ff})
        catch MyErr
            err_count = err_count + 1;
        end
        count = count + 1
        if count > 1000
            break
        end
    end
end







