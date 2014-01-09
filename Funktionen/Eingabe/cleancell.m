function ergebnis = cleancell(cellarray)
    for i=1:size(cellarray,1)
        for j=1:size(cellarray,2)
            if isnan(cellarray{i,j})
               ergebnis{i,j} = []; 
            else
                ergebnis{i,j} = cellarray{i,j};
            end
        end
    end
end