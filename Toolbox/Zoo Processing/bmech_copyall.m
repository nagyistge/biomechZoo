function bmech_copyall(fld1,fld2,ext)

% biomech_copyall(fld1,fld2) copies all files from fld1 to fld2
%
% ARGUMENTS
%  fld1   ...  folder to copy from
%  fld2   ...  folder to copy to
%  ext    ...  copy only by file extension. Default 'all'


% Revision History
%
% Created by Philippe C. Dixon Feb 2015
%
% Updated by Philippe C. Dixon May 2015
% - small bug fixes


% Part of the Zoosystem Biomechanics Toolbox 
%
% Main contributors:
% Philippe C. Dixon, Dept of Engineering Science. University of Oxford. Oxford, UK.
% Yannick Michaud-Paquette, Dept of Kinesiology. McGill University. Montreal, Canada.
% JJ Loh, Medicus Corda. Montreal, Canada.
% 
% Contact: 
% philippe.dixon@gmail.com
%
% Web: 
% https://github.com/PhilD001/the-zoosystem
%
% Referencing:
% please reference the paper below if the zoosystem was used in the preparation of a manuscript:
% Dixon PC, Loh JJ, Michaud-Paquette Y, Pearsall DJ. The Zoosystem: An Open-Source Movement Analysis 
% Matlab Toolbox.  Proceedings of the 23rd meeting of the European Society of Movement Analysis in 
% Adults and Children. Rome, Italy.Sept 29-Oct 4th 2014. 




tic
% Get files from database
%
if nargin==2
    fl = engine('path',fld1);
else
    fl = engine('path',fld1,'extension',ext);
end



% check if copy to folder exists
%
if exist(fld2,'dir')==0
    mkdir(fld2)
end

% check if paths end with slash
%
if ~strcmp(fld1(end),slash)
    fld1 = [fld1, slash];
end


if ~strcmp(fld2(end),slash)
    fld2 = [fld2, slash];
end


% copy files from fld1 to fld2
%
for i= 1:length(fl)
    
    batchdisplay(fl{i},'copying file')
    
    [p,f] = fileparts(fl{i});
    ext = extension(fl{i});
    
  
    % find subfolder
    %
    last_slash_indx = strfind(fld1,slash);   
    last_slash_indx = last_slash_indx(end);
    con = p(last_slash_indx+1:end);
    
    
    % copy to directory
    %
    dest = [fld2,con,slash];
    nfl =  [dest,f,ext];   
    
    if exist(dest,'dir')==0
        mkdir(dest)
    end
    
    r = copyfile(fl{i},nfl,'f');
    
    
    if r==0
        error('copy error detected')
    end
    
end

disp(['all files copied in ',num2str(toc)])