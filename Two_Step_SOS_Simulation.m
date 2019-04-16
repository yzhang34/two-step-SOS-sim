function varargout = Two_Step_SOS_Simulation(varargin)
% Two_Step_SOS_Simulation MATLAB code for Two_Step_SOS_Simulation.fig
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 16, 2019
%   Copyright: University of Notre Dame, 2019

% Edit the above text to modify the response to help Two_Step_SOS_Simulation

% Last Modified by GUIDE v2.5 16-Apr-2019 17:05:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Two_Step_SOS_Simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @Two_Step_SOS_Simulation_OutputFcn, ...
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


% --- Executes just before Two_Step_SOS_Simulation is made visible.
function Two_Step_SOS_Simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Two_Step_SOS_Simulation (see VARARGIN)

% Choose default command line output for Two_Step_SOS_Simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Two_Step_SOS_Simulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc

addpath('./functions')

set(hObject,'Toolbar','figure'); % let the toolbar be operable
plot_GUI(handles)


% --- Outputs from this function are returned to the command line.
function varargout = Two_Step_SOS_Simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Check_Loglog.
function Check_Loglog_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Loglog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_Loglog
plot_GUI(handles)

% --- Executes on slider movement.
function Slider_I01_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_I01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.Edit_I01, 'String', num2str(get(handles.Slider_I01, 'Value'),'%.4e'));
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Slider_I01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_I01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_I02_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_I02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

do_I0102_lock = get(handles.Check_I01I02_Lock, 'Value');
if do_I0102_lock
    I01_value = str2double(get(handles.Edit_I01, 'String'));
    I02_value = str2double(get(handles.Edit_I02, 'String'));
    d_value = I02_value - I01_value;
    I01_lock_value = get(handles.Slider_I02, 'Value')-d_value;
    set(handles.Slider_I01, 'Value', I01_lock_value)
    set(handles.Edit_I01, 'String', num2str(I01_lock_value,'%.4e'));
end
set(handles.Edit_I02, 'String', num2str(get(handles.Slider_I02, 'Value'),'%.4e'));
plot_GUI(handles)

% --- Executes during object creation, after setting all properties.
function Slider_I02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_I02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Edit_I01_Max_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_I01_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_I01_Max as text
%        str2double(get(hObject,'String')) returns contents of Edit_I01_Max as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_I01_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_I01_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_I02_Max_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_I02_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_I02_Max as text
%        str2double(get(hObject,'String')) returns contents of Edit_I02_Max as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_I02_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_I02_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Check_I01I02_Lock.
function Check_I01I02_Lock_Callback(hObject, eventdata, handles)
% hObject    handle to Check_I01I02_Lock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_I01I02_Lock
plot_GUI(handles)


% --- Executes on selection change in Popup_1PE2PE.
function Popup_1PE2PE_Callback(hObject, eventdata, handles)
% hObject    handle to Popup_1PE2PE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Popup_1PE2PE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Popup_1PE2PE
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Popup_1PE2PE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Popup_1PE2PE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_lambda as text
%        str2double(get(hObject,'String')) returns contents of Edit_lambda as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_NA_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_NA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_NA as text
%        str2double(get(hObject,'String')) returns contents of Edit_NA as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_NA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_NA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_lifetime as text
%        str2double(get(hObject,'String')) returns contents of Edit_lifetime as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_tob_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_tob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_tob as text
%        str2double(get(hObject,'String')) returns contents of Edit_tob as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_tob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_tob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_I01_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_I01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_I01 as text
%        str2double(get(hObject,'String')) returns contents of Edit_I01 as a double
set(handles.Slider_I01, 'Value', str2double(get(handles.Edit_I01, 'String')))

plot_GUI(handles)



% --- Executes during object creation, after setting all properties.
function Edit_I01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_I01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_I02_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_I02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_I02 as text
%        str2double(get(hObject,'String')) returns contents of Edit_I02 as a double
set(handles.Slider_I02, 'Value', str2double(get(handles.Edit_I02, 'String')))

plot_GUI(handles)



% --- Executes during object creation, after setting all properties.
function Edit_I02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_I02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_psi_F_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_psi_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_psi_F as text
%        str2double(get(hObject,'String')) returns contents of Edit_psi_F as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_psi_F_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_psi_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_N0_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_N0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_N0 as text
%        str2double(get(hObject,'String')) returns contents of Edit_N0 as a double
plot_GUI(handles)


% --- Executes during object creation, after setting all properties.
function Edit_N0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_N0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_1_FWHM_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_1_FWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_1_FWHM as text
%        str2double(get(hObject,'String')) returns contents of Edit_1_FWHM as a double


% --- Executes during object creation, after setting all properties.
function Edit_1_FWHM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_1_FWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_2_FWHM_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_2_FWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_2_FWHM as text
%        str2double(get(hObject,'String')) returns contents of Edit_2_FWHM as a double


% --- Executes during object creation, after setting all properties.
function Edit_2_FWHM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_2_FWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_SOS2_FWHM_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_SOS2_FWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_SOS2_FWHM as text
%        str2double(get(hObject,'String')) returns contents of Edit_SOS2_FWHM as a double


% --- Executes during object creation, after setting all properties.
function Edit_SOS2_FWHM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_SOS2_FWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Check_Log_k.
function Check_Log_k_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Log_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_Log_k
plot_GUI(handles)
