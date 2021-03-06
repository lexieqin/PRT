function result = prtTestRVUniformImproper

% Copyright (c) 2014 CoVar Applied Technologies
%
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.



result = true;


% Test the basic operation
dataSet    = prtDataGenUnimodal;
dataSetOneClass = prtDataSetClass(dataSet.getObservationsByClass(1));

try
    RV = prtRvUniformImproper;                       % Create a prtRVUniformImproper object
    RV = RV.mle(dataSetOneClass.getX);   % Compute the maximum
catch
    disp('prtRVUniformImproper basic operation fail')
    result= false;
end

% % make sure none of these error out
try
    RV.plotPdf                           % Plot the pdf
    close
catch
    disp('prtRVUniformImproper plot pdf fail')
    result = false;
    close
end

RVspec = prtRvUniformImproper;
% % Check that I can specify the number of dimensions
try
  RVspec.nDimensions = 2;
catch
    disp('prtRVUniformImproper  nDims set fail')
    result=  false;
end

%check the draw function
try
    sample = RV.draw(1);
catch
    disp('prtRVUniformImproper draw fail')
    result = false;
end

if( size(sample) ~= [1 1])
    disp('prtRVUniformImproper sample size incorrect')
    result = false;
end

% check the pdf and cdf functions
val1 = [];
try
    val1 = RV.pdf([ 0 0 ]);
    %val2 = RV.cdf([ 0 0]); % Cdf does not work in 2D
catch
    disp('prtRVUniformImproper pdf/cdf fail')
    result = false;
end

if ~isequal(val1,1)
    disp('prtRvUniformImproper pdf not 1')
    result = false;
end

% Make sure we error out on size mismatch
try
    val1 = RV.pdf([0]);
    val2 = RV.cdf([0]);
    disp('prtRVUniformImproper pdf/cdf size check fail')
    result = false;
catch
    % noop;
end
