function elements = parseElements( varargin )
% No input: Returns entire elemental data from z=1-95
% If input is a number or array of numbers, input selects elements by Z
% If input is comma or space delimited or cell array of strings, input selects elements by name
% e.g., 'Ca,Sr', 'Ca Sr', {'Ca', 'Sr'}
    if nargin == 1
        csvPath = './elements.csv';
        inPutVal = varargin{1};
    elseif nargin == 2
        csvPath = varargin{2};
        inputVal = varargin{1};
    end


    t = readtable('elements.csv');
    
    elements = table2struct(t(:,1:2)); 
    eds = table2struct(t(:,3:11));
    eels = table2struct(t(:,12:29));
    fparams = table2struct(t(:,30:41));
    
    
    for ind = 1:length(elements)
        elements(ind).EDS = eds(ind);
        elements(ind).EELS = eels(ind);
        elements(ind).fparams.a = [fparams(ind).a1,fparams(ind).a2,fparams(ind).a3];
        elements(ind).fparams.b = [fparams(ind).b1,fparams(ind).b2,fparams(ind).b3];
        elements(ind).fparams.c = [fparams(ind).c1,fparams(ind).c2,fparams(ind).c3];
        elements(ind).fparams.d = [fparams(ind).d1,fparams(ind).d2,fparams(ind).d3];
    end
    
    
    if nargin == 1 || 2
        if isnumeric( inputVal )
            elements = elements( inputVal );
        elseif iscell( inputVal ) || ischar( inputVal )
            if ischar( inputVal )
                inputVal = split(inputVal,{' ,',', '}) ;
                inputVal = split(inputVal,{',',' '}) ;
            end
            Zs = t.Z;
            names = t.Symbol;
            [Lia,Locb] = ismember( inputVal, names );
            % Check if all elements are valid
            if ~all(Lia)
                error( 'Error Parsing Input: Invalid Element Name')
            else
                elements = elements( Zs(Locb) );
            end           
        else
            error( 'Wrong Input Type' );
        end
    end
end

