function elements = parseElements( inputVal )
% No input: Returns entire elemental data from z=1-95
% If input is a number or array of numbers, input selects elements by Z
% If input is comma or space delimited or cell array of strings, input selects elements by name
% e.g., 'Ca,Sr', 'Ca Sr', {'Ca', 'Sr'}
    t = readtable('elements.csv');
    
    elements = table2struct(t(:,1:2)); 
    eds = table2struct(t(:,3:11));
    eels = table2struct(t(:,12:end));
    
    for ind = 1:length(elements)
        elements(ind).EDS = eds(ind);
       elements(ind).EELS = eels(ind);
    end
    
    
    if nargin == 1
        if isnumeric( inputVal )
            elements = elements( inputVal );
        elseif iscell( inputVal ) || ischar( inputVal )
            if ischar( inputVal )
                inputVal = split(inputVal,{' ',','}) ;
            end
            Zs = t.Z;
            names = t.Element;
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

