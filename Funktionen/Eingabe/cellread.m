function cellarray = cellread(file)
fid = fopen(file);
cellarray = {};
while (true)
    line = fgetl(fid);
    line = fgetl(fid);
    vektor = {};
    
    
    % line 2 vektor
        feld = '';
        while (size(line,2)>0)
            if (line(1)==';')
               vektor = [vektor feld]; 
               feld = '';
            else
               feld = [feld line(1)] ;
            end
            line = line(2:end);
  
        end
    
    
    [cellarray vektor] = anpassen(cellarray,vektor);
    cellarray = [cellarray;vektor];
    
    if feof(fid)
       break 
    end
end
cellarray = cleancell(cellarray);
fclose(fid);
clear fid line vektor feld
end

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

function [x y] = anpassen(a, b)
maxbreite = max(size(a,2),size(b,2));
 x = repmat({NaN},size(a,1),maxbreite);
     for z=1:size(x,1)
        for s=1:size(a,2)
           x(z,s) = a(z,s); 
        end
     end
    
y = repmat({NaN},size(b,1),maxbreite);

     for z=1:size(y,1)
        for s=1:size(b,2)
           y(z,s) = b(z,s); 
        end
     end
end