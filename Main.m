function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 23-May-2022 14:23:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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

function radio_off(handles)
set(handles.radio_min,'value',0)
set(handles.radio_shp,'value',0)
set(handles.radio_edp,'value',0)
set(handles.radio_uns,'value',0)
set(handles.radio_covert,'value',0)
set(handles.radio_neg,'value',0)
set(handles.radio_bright,'value',0)
set(handles.radio_pw,'value',0)
set(handles.radio_histoD,'value',0)
set(handles.radio_histoE,'value',0)
set(handles.radio_histoM,'value',0)
set(handles.radio_add,'value',0)
set(handles.radio_sub,'value',0)
set(handles.radio_wm,'value',0)
set(handles.radio_contrast,'value',0)
set(handles.radio_quan,'value',0)
set(handles.radio_restoreGG,'value',0)
set(handles.radio_restoreSMI,'value',0)
set(handles.radio_restoreSME,'value',0)

% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.edit_result,'visible','off')


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in pop_di.
function pop_di_Callback(hObject, eventdata, handles)
% hObject    handle to pop_di (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_di contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_di

radio_off(handles)
x = handles.img;
type = get(hObject,'value');
fact =  str2double( get(handles.edit_fact,'string') );
    
switch type
    case 1
        warndlg('Please choose any type');
        set(hObject,'value',1);
    case 2
        result = Resize_1order(x,fact);
    case 3
        result = DM_0order(x,fact);
end

axes(handles.axes2);
imshow(result);

if(type == 2)
    set(handles.edit_result,'string','Maxi Resize 1-order')
elseif(type == 3)
    set(handles.edit_result,'string','Maxi Resize 0-order')
end

set(handles.edit_result,'visible','on')
set(hObject,'value',1);

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    if(type == 2)
    title('Maxi Resize 1-order');
    elseif(type == 3)
    title('Maxi Resize 0-order');
    end
   
end

if( (get(handles.radio_save,'value')) == 1)
    if(type == 2)
    imwrite(result,'Result_maxi1.jpg');
    elseif(type == 3)
    imwrite(result,'Result_maxi0.jpg');
    end
  
end
 


% --- Executes during object creation, after setting all properties.
function pop_di_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_di (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_covert.
function radio_covert_Callback(hObject, eventdata, handles)
% hObject    handle to radio_covert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_covert

radio_off(handles)
set(handles.radio_covert,'value',1)
x = handles.img;
result = convert_to_gray(x);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Convert To Gray')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Result - Converted Image To Gray');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_ConvertToGray.jpg');
end


% --- Executes on button press in radio_bright.
function radio_bright_Callback(hObject, eventdata, handles)
% hObject    handle to radio_bright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_bright

radio_off(handles)
set(handles.radio_bright,'value',1)
offest =  str2double( get(handles.edit_offest,'string') );
if(offest >= 0 && offest <= 255)
    x = handles.img;
    result = brightness(x,offest);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string',sprintf('Brightness Effect (%.1f) offest',offest))
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('Original');
        figure ,imshow(result);
        title(sprintf('Brightness Effect (%d) offest',offest));
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_Brightness.jpg');
    end
else
    warndlg('The Offest must be only from 0 to 255');
    set(handles.radio_bright,'value',0)
end


function edit_offest_Callback(hObject, eventdata, handles)
% hObject    handle to edit_offest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_offest as text
%        str2double(get(hObject,'String')) returns contents of edit_offest as a double


% --- Executes during object creation, after setting all properties.
function edit_offest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_offest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_pw.
function radio_pw_Callback(hObject, eventdata, handles)
% hObject    handle to radio_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_pw

radio_off(handles)
set(handles.radio_pw,'value',1)
pw =  str2double( get(handles.edit_pw,'string') );
if(pw > 0)
    x = handles.img;
    result = powerLaw(x,pw);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string',sprintf('Power Law Effect (%.3f) Gamma',pw))
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('Original');
        figure ,imshow(result);
        title(sprintf('Power Law Effect (%.3f) Gamma',pw));
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_PowerLaw.jpg');
    end
else
   warndlg('The power must be bigger than 0');
    set(handles.radio_pw,'value',0)
end

function edit_pw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pw as text
%        str2double(get(hObject,'String')) returns contents of edit_pw as a double

% --- Executes during object creation, after setting all properties.
function edit_pw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_neg.
function radio_neg_Callback(hObject, eventdata, handles)
% hObject    handle to radio_neg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_neg

radio_off(handles)
set(handles.radio_neg,'value',1)
x = handles.img;
result = negative(x);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string',' Negative Effect')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Negative Effect');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_Negative.jpg');
end

% --- Executes on button press in radio_histoD.
function radio_histoD_Callback(hObject, eventdata, handles)
% hObject    handle to radio_histoD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_histoD

radio_off(handles)
set(handles.radio_histoD,'value',1)
x = handles.img;
result = histogram(x);
axes(handles.axes2);
stem(0:255,result);
xlabel('Color Levels');
ylabel('No. of Pixels');

set(handles.edit_result,'string','Image Histogram')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,stem(0:255,result);
    xlabel('Color Levels');
    ylabel('No. of Pixels');
    title('Image Histogram');
end

% --- Executes on button press in radio_histoE.
function radio_histoE_Callback(hObject, eventdata, handles)
% hObject    handle to radio_histoE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_histoE

radio_off(handles)
set(handles.radio_histoE,'value',1)
x = handles.img;
result = histogram_equ(x);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Histogram Equalization')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Histogram Equalization');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_equalization.jpg');
end


% --- Executes on button press in radio_min.
function radio_min_Callback(hObject, eventdata, handles)
% hObject    handle to radio_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_min

radio_off(handles)
set(handles.radio_min,'value',1)

x = handles.img;
fact =  str2double( get(handles.edit_fact,'string') );
result = Resize_0oreder_min(x,fact);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Minimization')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Minimization');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_minimization.jpg');
end


function edit_fact_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fact as text
%        str2double(get(hObject,'String')) returns contents of edit_fact as a double


% --- Executes during object creation, after setting all properties.
function edit_fact_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_histoM.
function radio_histoM_Callback(hObject, eventdata, handles)
% hObject    handle to radio_histoM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_histoM

radio_off(handles)
set(handles.radio_histoM,'value',1)
x = handles.img;
y = handles.img2;
result = histogram_match(x,y);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Histogram Matching')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Histogram Matching');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_matching.jpg');
end

% --- Executes on button press in radio_add.
function radio_add_Callback(hObject, eventdata, handles)
% hObject    handle to radio_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_add

radio_off(handles)
set(handles.radio_add,'value',1)
x = handles.img;
y = handles.img2;
[r1,c1,ch1]=size(x);
[r2,c2,ch2]=size(y);

if(ch1 == ch2) 
    result = add(x,y);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string','Addition')
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('First Image');
        figure ,imshow(y);
        title('Seconed Image');
        figure ,imshow(result);
        title('Addition');
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_addition.jpg');
    end
else
    warndlg('Both Images Must be have the same channels (both Gray) or (both RGB)');
    set(handles.radio_add,'value',0)
end

% --- Executes on button press in radio_sub.
function radio_sub_Callback(hObject, eventdata, handles)
% hObject    handle to radio_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_sub

radio_off(handles)
set(handles.radio_sub,'value',1)
x = handles.img;
y = handles.img2;
[r1,c1,ch1]=size(x);
[r2,c2,ch2]=size(y);

if(ch1 == ch2) 
    result = sub(x,y);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string','Subtraction')
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('First Image');
        figure ,imshow(y);
        title('Seconed Image');
        figure ,imshow(result);
        title('Subtraction');
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_subtraction.jpg');
    end
else
    warndlg('Both Images Must be have the same channels (both Gray) or (both RGB)');
    set(handles.radio_sub,'value',0)
end

% --- Executes on button press in push_extImg.
function push_extImg_Callback(hObject, eventdata, handles)
% hObject    handle to push_extImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.jpg', 'Pick an image');
name2 = strcat(pathname,filename);
if isequal(filename,0) || isequal(pathname,0)
    warndlg('Image is not selected');
else
    img2=imread(name2);
    axes(handles.axes3);
    imshow(img2);
    
    handles.name2=name2;
    handles.img2=img2;
    guidata(hObject, handles);
    helpdlg('Input image is Selected');
end


% --- Executes on button press in radio_contrast.
function radio_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to radio_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_contrast

radio_off(handles)
set(handles.radio_contrast,'value',1)
max =  str2double( get(handles.edit_newMax,'string') );
min =  str2double( get(handles.edit_newMin,'string') );
if(max >= 0 && max <= 255 && min >= 0 && min <= 255)
    x = handles.img;
    result = contrast(x,max,min);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string',sprintf('Contrast Effect [%d~%d]',min,max))
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('Original');
        figure ,imshow(result);
        title(sprintf('Contrast Effect [%d~%d]',min,max));
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_Contrast.jpg');
    end
else
    warndlg('The New Max and New Min must be only from 0 to 255');
    set(handles.radio_contrast,'value',0)
end


function edit_newMax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_newMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_newMax as text
%        str2double(get(hObject,'String')) returns contents of edit_newMax as a double

% --- Executes during object creation, after setting all properties.
function edit_newMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_newMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_smooth.
function pop_smooth_Callback(hObject, eventdata, handles)
% hObject    handle to pop_smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_smooth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_smooth

radio_off(handles)
x = handles.img;
type = get(hObject,'value');
mask =  str2double( get(handles.edit_mask,'string') );
sigma =  str2double( get(handles.edit_sigma,'string') );
if( mod(mask,2) ~= 0 && mask >= 3 && sigma >= 0.5)
    switch type
        case 1
            warndlg('Please choose any type');
            set(hObject,'value',1);
        case 2
            ss = "avg";
            cout = "Averaging Smoothing Filter";
            result = smooth_avg(x,mask);
        case 3
            ss = "wei";
            cout = "Weighted Smoothing Filter";
            result = smooth_weighted(x,sigma);
        case 4
            ss = "med";
            cout = "Median Smoothing Filter";
            result = smooth_median(x,mask);
        case 5
            ss = "max";
            cout = "Max Smoothing Filter";
            result = smooth_max(x,mask);
        case 6
            ss = "min";
            cout = "Min Smoothing Filter";
            result = smooth_min(x,mask);
    end

    axes(handles.axes2);
    imshow(result);

    if(cout == "Weighted Smoothing Filter")
        set(handles.edit_result,'string',sprintf('%s Sigma=%.2f (%dx%d) mask',cout,sigma,mask,mask));
    else
        set(handles.edit_result,'string',sprintf('%s (%dx%d) mask',cout,mask,mask));
    end
    
    set(handles.edit_result,'visible','on')
    set(hObject,'value',1);

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('Original');
        figure ,imshow(result);
        if(cout == "Weighted Smoothing Filter")
            title(sprintf('%s Sigma=%.2f (%dx%d) mask',cout,sigma,mask,mask));
        else
            title(sprintf('%s (%dx%d) mask',cout,mask,mask));
        end
    end

    if( (get(handles.radio_save,'value')) == 1)
        if(ss == "avg")
            imwrite(result,'Result_avgSmooth.jpg');
        elseif (ss == "wei")
            imwrite(result,'Result_weightedSmooth.jpg');
        elseif (ss == "med")
            imwrite(result,'Result_medianSmooth.jpg');
        elseif (ss == "max")
            imwrite(result,'Result_maxSmooth.jpg');
        elseif (ss == "min")
            imwrite(result,'Result_minSmooth.jpg');
        end
    end

else
    warndlg('The mask must be odd and larger than 1 and sigma must equal 0.5 or larger');
    set(hObject,'value',1)
end

% --- Executes during object creation, after setting all properties.
function pop_smooth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_newMin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_newMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_newMin as text
%        str2double(get(hObject,'String')) returns contents of edit_newMin as a double


% --- Executes during object creation, after setting all properties.
function edit_newMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_newMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_low.
function pop_low_Callback(hObject, eventdata, handles)
% hObject    handle to pop_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_low contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_low

radio_off(handles)
x = handles.img;
type = get(hObject,'value');
D =  str2double( get(handles.edit_D,'string') );
n =  str2double( get(handles.edit_n,'string') );

switch type
    case 1
        warndlg('Please choose any type');
        set(hObject,'value',1);
    case 2
        ss = "avg";
        cout = "Ideal LPF";
        result = LPF_ideal(x,D);
    case 3
        ss = "wei";
        cout = "Butterworth LPF";
        result = LPF_butterworth(x,D,n);
    case 4
        ss = "med";
        cout = "Gaussian LPF";
        result = LPF_gaussian(x,D);
end

axes(handles.axes2);
imshow(result);

if(cout == "Butterworth LPF")
set(handles.edit_result,'string',sprintf('%s (D=%d)-(n=%d)',cout,D,n));
else
set(handles.edit_result,'string',sprintf('%s (D=%d)',cout,D));
end


set(handles.edit_result,'visible','on')
set(hObject,'value',1);

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title(sprintf('%s',cout));
end

if( (get(handles.radio_save,'value')) == 1)
    if(ss == "avg")
        imwrite(result,'Result_LPFi.jpg');
    elseif (ss == "wei")
        imwrite(result,'Result_LPFb.jpg');
    elseif (ss == "med")
        imwrite(result,'Result_LPFg.jpg');
    end
end



% --- Executes during object creation, after setting all properties.
function pop_low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_high.
function pop_high_Callback(hObject, eventdata, handles)
% hObject    handle to pop_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_high contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_high

radio_off(handles)
x = handles.img;
type = get(hObject,'value');
D =  str2double( get(handles.edit_D,'string') );
n =  str2double( get(handles.edit_n,'string') );

switch type
    case 1
        warndlg('Please choose any type');
        set(hObject,'value',1);
    case 2
        ss = "avg";
        cout = "Ideal HPF";
        result = HPF_ideal(x,D);
    case 3
        ss = "wei";
        cout = "Butterworth HPF";
        result = HPF_butterworth(x,D,n);
    case 4
        ss = "med";
        cout = "Gaussian HPF";
        result = HPF_gaussian(x,D);
end

axes(handles.axes2);
imshow(result);


if(cout == "Butterworth HPF")
set(handles.edit_result,'string',sprintf('%s (D=%d)-(n=%d)',cout,D,n));
else
set(handles.edit_result,'string',sprintf('%s (D=%d)',cout,D));
end


set(handles.edit_result,'visible','on')
set(hObject,'value',1);

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title(sprintf('%s',cout));
end

if( (get(handles.radio_save,'value')) == 1)
    if(ss == "avg")
        imwrite(result,'Result_HPFi.jpg');
    elseif (ss == "wei")
        imwrite(result,'Result_HPFb.jpg');
    elseif (ss == "med")
        imwrite(result,'Result_HPFg.jpg');
    end
end

% --- Executes during object creation, after setting all properties.
function pop_high_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_shp.
function radio_shp_Callback(hObject, eventdata, handles)
% hObject    handle to radio_shp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_shp

radio_off(handles)
set(handles.radio_shp,'value',1)

x = handles.img;
result = Sharp_point(x);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Point Sharpening')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Point Sharpening');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_pointSharp.jpg');
end



% --- Executes on selection change in pop_shl.
function pop_shl_Callback(hObject, eventdata, handles)
% hObject    handle to pop_shl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_shl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_shl

radio_off(handles)
x = handles.img;
type = get(hObject,'value');

switch type
    case 1
        warndlg('Please choose any type');
        set(hObject,'value',1);
    case 2
        ss = "shlv";
        cout = "Line Sharpening (Vertical)";
        result = Sharp_lineVertical(x);
    case 3
        ss = "shlh";
        cout = "Line Sharpening (Horizontal)";
        result = Sharp_lineHorizontal(x);
    case 4
        ss = "shld1";
        cout = "Line Sharpening (Diagonal \)";
        result = Sharp_lineDiagonalL(x);
    case 5
        ss = "shld2";
        cout = "Line Sharpening (Diagonal /)";
        result = Sharp_lineDiagonalR(x);
end

axes(handles.axes2);
imshow(result);


set(handles.edit_result,'string',sprintf('%s',cout));
set(handles.edit_result,'visible','on')
set(hObject,'value',1);

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title(sprintf('%s',cout));
end

if( (get(handles.radio_save,'value')) == 1)
    if(ss == "shlv")
        imwrite(result,'Result_lineSharpV.jpg');
    elseif (ss == "shlh")
        imwrite(result,'Result_lineSharpH.jpg');
    elseif (ss == "shld1")
        imwrite(result,'Result_lineSharpD1.jpg');
    elseif (ss == "shld2")
        imwrite(result,'Result_lineSharpD2.jpg');
    end
end

% --- Executes during object creation, after setting all properties.
function pop_shl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_shl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_edp.
function radio_edp_Callback(hObject, eventdata, handles)
% hObject    handle to radio_edp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_edp

radio_off(handles)
set(handles.radio_edp,'value',1)

x = handles.img;
result = EdgeDetect_point(x);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Edge Detection')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Point Edge Detection');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_pointEdge.jpg');
end

% --- Executes on selection change in pop_edl.
function pop_edl_Callback(hObject, eventdata, handles)
% hObject    handle to pop_edl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_edl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_edl

radio_off(handles)
x = handles.img;
type = get(hObject,'value');

switch type
    case 1
        warndlg('Please choose any type');
        set(hObject,'value',1);
    case 2
        ss = "shlv";
        cout = "Line Edge Detection (Vertical)";
        result = EdgeDetect_lineVertical(x);
    case 3
        ss = "shlh";
        cout = "Line Edge Detection (Horizontal)";
        result = EdgeDetect_lineHorizontal(x);
    case 4
        ss = "shld1";
        cout = "Line Edge Detection (Diagonal \)";
        result = EdgeDetect_lineDiagonalL(x);
    case 5
        ss = "shld2";
        cout = "Line Edge Detection (Diagonal /)";
        result = EdgeDetect_lineDiagonalR(x);
end

axes(handles.axes2);
imshow(result);


set(handles.edit_result,'string',sprintf('%s',cout));
set(handles.edit_result,'visible','on')
set(hObject,'value',1);

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title(sprintf('%s',cout));
end

if( (get(handles.radio_save,'value')) == 1)
    if(ss == "shlv")
        imwrite(result,'Result_lineEdgeV.jpg');
    elseif (ss == "shlh")
        imwrite(result,'Result_lineEdgeH.jpg');
    elseif (ss == "shld1")
        imwrite(result,'Result_lineEdgeD1.jpg');
    elseif (ss == "shld2")
        imwrite(result,'Result_lineEdgeD2.jpg');
    end
end

% --- Executes during object creation, after setting all properties.
function pop_edl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_edl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_uns.
function radio_uns_Callback(hObject, eventdata, handles)
% hObject    handle to radio_uns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_uns

radio_off(handles)
set(handles.radio_uns,'value',1)

x = handles.img;
result = Unsharp_masking(x);
axes(handles.axes2);
imshow(result);

set(handles.edit_result,'string','Unsharpe Masking')
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(result);
    title('Unsharpe Masking');
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_unsharpeMask.jpg');
end

% --- Executes on button press in radio_quan.
function radio_quan_Callback(hObject, eventdata, handles)
% hObject    handle to radio_quan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_quan

radio_off(handles)
set(handles.radio_quan,'value',1)
k =  str2double( get(handles.edit_quanK,'string') );
if(k >= 1 && k <= 8)
    x = handles.img;
    result = quantization(x,k);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string',sprintf('Quantization [%d] k',k))
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('Original');
        figure ,imshow(result);
        title(sprintf('Quantization [%d] k',k));
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_quantization.jpg');
    end
else
    warndlg('K value must be from 1 to 8');
    set(handles.radio_quan,'value',0)
end

% --- Executes on button press in radio_wm.
function radio_wm_Callback(hObject, eventdata, handles)
% hObject    handle to radio_wm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_wm

radio_off(handles)
set(handles.radio_wm,'value',1)
x = handles.img;
y = handles.img2;
[r1,c1,ch1]=size(x);
[r2,c2,ch2]=size(y);

if(ch1 == ch2) 
    result = waterMark(x,y);
    axes(handles.axes2);
    imshow(result);

    set(handles.edit_result,'string','Water Mark')
    set(handles.edit_result,'visible','on')

    if( (get(handles.sdd,'value')) == 1)
        figure ,imshow(x);
        title('First Image');
        figure ,imshow(y);
        title('Seconed Image');
        figure ,imshow(result);
        title('Water Mark');
    end

    if( (get(handles.radio_save,'value')) == 1)
        imwrite(result,'Result_WaterMark.jpg');
    end
else
    warndlg('Both Images Must be have the same channels (both Gray) or (both RGB)');
    set(handles.radio_wm,'value',0)
end

% --- Executes on button press in radio_restoreGG.
function radio_restoreGG_Callback(hObject, eventdata, handles)
% hObject    handle to radio_restoreGG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_restoreGG

radio_off(handles)
set(handles.radio_restoreGG,'value',1)

x = handles.img;
noised_x = imnoise(x,'gaussian');
mask =  str2double( get(handles.edit_mask,'string') );
result = gaussian_geometric(x,mask);

axes(handles.axes3);
imshow(noised_x);

axes(handles.axes2);
imshow(result);


set(handles.edit_result,'string',sprintf('Restoration:Geometric filter(%d*%d)mask',mask,mask))
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(noised_x);
    title('Noised Image');
    figure ,imshow(result);
    title(sprintf('Restoration: Geometric filter (%d*%d) mask',mask,mask));
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_restGeo.jpg');
end

% --- Executes on button press in radio_restoreSMI.
function radio_restoreSMI_Callback(hObject, eventdata, handles)
% hObject    handle to radio_restoreSMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_restoreSMI

radio_off(handles)
set(handles.radio_restoreSMI,'value',1)

x = handles.img;
noised_x = imnoise(x,'salt & pepper');
mask =  str2double( get(handles.edit_mask,'string') );
result = saltPepper_midPoint(x,mask);

axes(handles.axes3);
imshow(noised_x);

axes(handles.axes2);
imshow(result);


set(handles.edit_result,'string',sprintf('Restoration:Mid filter(%d*%d)mask',mask,mask))
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(noised_x);
    title('Noised Image');
    figure ,imshow(result);
    title(sprintf('Restoration: Mid filter (%d*%d) mask',mask,mask));
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_restMid.jpg');
end

% --- Executes on button press in radio_restoreSME.
function radio_restoreSME_Callback(hObject, eventdata, handles)
% hObject    handle to radio_restoreSME (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_restoreSME

radio_off(handles)
set(handles.radio_restoreSME,'value',1)

x = handles.img;
noised_x = imnoise(x,'salt & pepper');
mask =  str2double( get(handles.edit_mask,'string') );
result = saltPepper_median(x,mask);

axes(handles.axes3);
imshow(noised_x);

axes(handles.axes2);
imshow(result);


set(handles.edit_result,'string',sprintf('Restoration:Median filter(%d*%d)mask',mask,mask))
set(handles.edit_result,'visible','on')

if( (get(handles.sdd,'value')) == 1)
    figure ,imshow(x);
    title('Original');
    figure ,imshow(noised_x);
    title('Noised Image');
    figure ,imshow(result);
    title(sprintf('Restoration: Median filter (%d*%d) mask',mask,mask));
end

if( (get(handles.radio_save,'value')) == 1)
    imwrite(result,'Result_restMed.jpg');
end

% --- Executes on button press in push_origin.
function push_origin_Callback(hObject, eventdata, handles)
% hObject    handle to push_origin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.jpg', 'Pick an image');
name = strcat(pathname,filename);
if isequal(filename,0) || isequal(pathname,0)
    warndlg('Image is not selected');
else
    img=imread(name);
    axes(handles.axes1);
    imshow(img);
    
    handles.name=name;
    handles.img=img;
    guidata(hObject, handles);
    helpdlg('Input image is Selected');
end

function edit_quanK_Callback(hObject, eventdata, handles)
% hObject    handle to edit_quanK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_quanK as text
%        str2double(get(hObject,'String')) returns contents of edit_quanK as a double

% --- Executes during object creation, after setting all properties.
function edit_quanK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_quanK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double

% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sdd.
function sdd_Callback(hObject, eventdata, handles)
% hObject    handle to sdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sdd


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in radio_save.
function radio_save_Callback(hObject, eventdata, handles)
% hObject    handle to radio_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_save



function edit_D_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D as text
%        str2double(get(hObject,'String')) returns contents of edit_D as a double


% --- Executes during object creation, after setting all properties.
function edit_D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n as text
%        str2double(get(hObject,'String')) returns contents of edit_n as a double


% --- Executes during object creation, after setting all properties.
function edit_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mask_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mask as text
%        str2double(get(hObject,'String')) returns contents of edit_mask as a double


% --- Executes during object creation, after setting all properties.
function edit_mask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
