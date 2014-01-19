function varargout = KEP(varargin)
% KEP MATLAB code for KEP.fig
%      KEP, by itself, creates a new KEP or raises the existing
%      singleton*.
%
%      H = KEP returns the handle to a new KEP or the handle to
%      the existing singleton*.
%
%      KEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KEP.M with the given KEP arguments.
%
%      KEP('Property','Value',...) creates a new KEP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KEP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KEP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KEP

% Last Modified by GUIDE v2.5 19-Jan-2014 21:45:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KEP_OpeningFcn, ...
                   'gui_OutputFcn',  @KEP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before KEP is made visible.
function KEP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KEP (see VARARGIN)
addpath(genpath('Funktionen\'));
addpath(genpath('Allgemeines'));
config;

% Choose default command line output for KEP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KEP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KEP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popup_kwparks.
function popup_kwparks_Callback(hObject, eventdata, handles)
% hObject    handle to popup_kwparks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_kwparks contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_kwparks


% --- Executes during object creation, after setting all properties.
function popup_kwparks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_kwparks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_marktgebiet.
function popup_marktgebiet_Callback(hObject, eventdata, handles)
% hObject    handle to popup_marktgebiet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_marktgebiet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_marktgebiet
handles.config.mg = get(handles.popup_marktgebiet,'Value');
updategui;

% --- Executes during object creation, after setting all properties.
function popup_marktgebiet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_marktgebiet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
% --- Executes on selection change in popup_plot.
function popup_plot_Callback(hObject, eventdata, handles)
% hObject    handle to popup_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_plot
updategui;

% --- Executes during object creation, after setting all properties.
function popup_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_savedata.
function btn_savedata_Callback(hObject, eventdata, handles)
% hObject    handle to btn_savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
daten_speichern;
updategui;

% --- Executes on button press in btn_loaddata.
function btn_loaddata_Callback(hObject, eventdata, handles)
% hObject    handle to btn_loaddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
daten_laden;
updategui;


% --- Executes on button press in btn_erstelleSEKKMatrix.
function btn_erstelleSEKKMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to btn_erstelleSEKKMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
erstelleSEKKMatrix;
updategui;


% --- Executes on selection change in popup_export.
function popup_export_Callback(hObject, eventdata, handles)
% hObject    handle to popup_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_export contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_export
handles.config.t = get(handles.popup_export,'Value');
updategui;

% --- Executes during object creation, after setting all properties.
function popup_export_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_cplex.
function btn_cplex_Callback(hObject, eventdata, handles)
% hObject    handle to btn_cplex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
speichereinsatz;
updategui;


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('stop');


% --- Executes on selection change in info.
function info_Callback(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns info contents as cell array
%        contents{get(hObject,'Value')} returns selected item from info


% --- Executes during object creation, after setting all properties.
function info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_berechnung_imex_Callback(hObject, eventdata, handles)
% hObject    handle to menu_berechnung_imex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  calculation_successfull = true;
  main_ImEx;
  updategui;
  try
catch fehler
  calculation_successfull = false;
  disp('Fehler in der Berechnung');
  disp(fehler);
end
if calculation_successfull
  set(handles.menu_datenspeichern_integral,'Enable','on');
end


% --------------------------------------------------------------------
function menu_berechnung_cplex_Callback(hObject, eventdata, handles)
% hObject    handle to menu_berechnung_cplex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
testelinprog;
updategui;

% --------------------------------------------------------------------
function menu_datenzwischenspeichern_Callback(hObject, eventdata, handles)
% hObject    handle to menu_datenzwischenspeichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
daten_zwischenspeichern;
updategui;

% --------------------------------------------------------------------
function menu_datenladen_Callback(hObject, eventdata, handles)
% hObject    handle to menu_datenladen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_data_load;
updategui;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_datenspeichern_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to menu_datenspeichern_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_data_export_analysis;
updategui;


% --------------------------------------------------------------------
function menu_datenspeichern_integral_Callback(hObject, eventdata, handles)
% hObject    handle to menu_datenspeichern_integral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
string_datum = strrep(datestr(now), ':', '_');
string_datum(15) = 'h';
string_datum(18) = 'm';
string_datum(21) = 's';
daten_speichern_integral;
main_data_export_analysis;


% --------------------------------------------------------------------
function menu_data_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_data_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

eingabe_erfolgreich = true;
main_data_open;
main_init;
updategui;
try
catch
disp('Fehler beim Einlesen der Daten');  
fprintf('fprintf');
eingabe_erfolgreich = false;
end

if eingabe_erfolgreich
  set(handles.menu_berechnung_imex,'Enable','on');
  set(handles.panel_trade,'Visible','on');
  set(handles.panel_pp,'Visible','on');
set(handles.panel_ntc,'Visible','on');
set(handles.panel_plot,'Visible','on');
set(handles.info,'Visible','on');
end


% --- Executes on selection change in status.
function status_Callback(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns status contents as cell array
%        contents{get(hObject,'Value')} returns selected item from status


% --- Executes during object creation, after setting all properties.
function status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_hydro_full_Callback(hObject, eventdata, handles)
% hObject    handle to menu_hydro_full (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.menu_hydro_full,'Checked'),'off')
  set(handles.menu_hydro_full,'Checked','on')
else
  set(handles.menu_hydro_full,'Checked','off')
end


% --------------------------------------------------------------------
function menu_data_open_entsoe_Callback(hObject, eventdata, handles)
% hObject    handle to menu_data_open_entsoe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_data_open_entsoe;
