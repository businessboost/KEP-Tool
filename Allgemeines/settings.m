function x = settings(value)
switch value
  case 'test' 
    x = 'test erfolgreich';
  % definition of columns
  case 'Spalte_KW_id'
    x = 'A';
  case 'Spalte_KW_Pmin'
    x = 'K';
  case 'Spalte_KW_Pmax'
    x = 'J';
  case 'Spalte_KW_eta'
    x = 'G';
  case 'Spalte_KW_e'
    x = 'H';
  case 'Spalte_KW_kb'
    x = 'I';
  case 'Spalte_KW_kurzname'
    x = 'C';
  case 'Spalte_KW_typ'
    x = 'F';
  case 'Spalte_KW_bezSO'
    x = 'B';
  case 'Spalte_KW_bezeichner'
    x = 'E';
  case 'Spalte_KW_langname'
    x = 'F';
  case 'Spalte_KW_Un'
    x = 'D';
  % CO2-price
  case 'co2preis'
    x = 12;
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';
  case ''
    x = '';

  otherwise
    x = 0;
end