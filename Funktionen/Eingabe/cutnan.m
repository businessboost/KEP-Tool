%überprüft 1. Zeile und Spalte und schneidet ab dem 1. NaN die Matrix ab.
function ergebnis = cutnan(cellarray)
ergebnis = cellarray;
    for i=1:size(cellarray,1)
        if isnan(cellarray{i,1})
               ergebnis = ergebnis(1:i-1,:); 
               break;
            end
    end
    
    for j=1:size(cellarray,2)
            if isnan(cellarray{1,j})
               ergebnis = ergebnis(:,1:j-1); 
               break;
            end 
    end
end