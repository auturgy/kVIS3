% kVIS3 Data Visualisation
%
% Copyright (C) 2012 - present  Kai Lehmkuehler, Matt Anderson and
% contributors
%
% Contact: kvis3@uav-flightresearch.com
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

function handles = kVIS_uiSetupPanelDataRange(handles, uiPanelDataRange)

if ~nargin
    close all;
    clc
    kVIS3;
    return;
end

uiDataRangeGrid = uix.Grid('Parent',uiPanelDataRange,'Backgroundcolor',handles.preferences.uiBackgroundColour,'Spacing',4,'Padding',2);

% Label
uicontrol(uiDataRangeGrid,'Style','text',...
    'String','Data Range:','FontWeight','bold',...
    'Backgroundcolor',handles.preferences.uiBackgroundColour, 'Foregroundcolor','w','FontSize',18, 'HorizontalAlignment', 'left');

% X
uicontrol(uiDataRangeGrid,'Style','text',...
    'String','Time (X) Limits',...
    'Backgroundcolor',handles.preferences.uiBackgroundColour, 'Foregroundcolor','w','FontSize',15, 'HorizontalAlignment', 'left');

% YL
uicontrol(uiDataRangeGrid,'Style','text',...
    'String','Vert. (YL) Limits',...
    'Backgroundcolor',handles.preferences.uiBackgroundColour, 'Foregroundcolor','w','FontSize',15, 'HorizontalAlignment', 'left');

% YR
uicontrol(uiDataRangeGrid,'Style','text',...
    'String','Vert. (YR) Limits',...
    'Backgroundcolor',handles.preferences.uiBackgroundColour, 'Foregroundcolor','w','FontSize',15, 'HorizontalAlignment', 'left',...
    'Enable', 'off');


% edit boxes

uix.Empty('Parent', uiDataRangeGrid);

handles.uiDataRange.Xmin = uicontrol(uiDataRangeGrid,'Style','edit',...
    'String','',...
    'Callback', {@kVIS_dataRangeUpdate_Callback, 'XLim'});

handles.uiDataRange.YLmin = uicontrol(uiDataRangeGrid,'Style','edit',...
    'String','',...
    'Callback', {@kVIS_dataRangeUpdate_Callback, 'YlLim'});

handles.uiDataRange.YRmin = uicontrol(uiDataRangeGrid,'Style','edit',...
    'String','',...
    'Callback', {@kVIS_dataRangeUpdate_Callback, 'YrLim'},...
    'Enable', 'off');

handles.uiDataRange.YTmin = [];


uix.Empty('Parent', uiDataRangeGrid);


handles.uiDataRange.Xmax = uicontrol(uiDataRangeGrid,'Style','edit',...
    'String','',...
    'Callback', {@kVIS_dataRangeUpdate_Callback, 'XLim'});

handles.uiDataRange.YLmax = uicontrol(uiDataRangeGrid,'Style','edit',...
    'String','',...
    'Callback', {@kVIS_dataRangeUpdate_Callback, 'YlLim'});

handles.uiDataRange.YRmax = uicontrol(uiDataRangeGrid,'Style','edit',...
    'String','',...
    'Callback', {@kVIS_dataRangeUpdate_Callback, 'YrLim'},...
    'Enable', 'off');

handles.uiDataRange.YTmax = [];

% Buttons

uix.Empty('Parent', uiDataRangeGrid);

uicontrol(uiDataRangeGrid,'Style','pushbutton',...
    'String','Clear X-Lim',...
    'Callback', {@kVIS_clearPlotLim_Callback, 'XLim'});

uicontrol(uiDataRangeGrid,'Style','pushbutton',...
    'String','Clear YL-Lim',...
    'Callback', {@kVIS_clearPlotLim_Callback, 'YlLim'});

uicontrol(uiDataRangeGrid,'Style','pushbutton',...
    'String','Clear YR-Lim',...
    'Callback', {@kVIS_clearPlotLim_Callback, 'YrLim'},...
    'Enable', 'off');


uiDataRangeGrid.Widths = [-1 80 80 70];