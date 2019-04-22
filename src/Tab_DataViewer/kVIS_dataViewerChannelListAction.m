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

function kVIS_dataViewerChannelListAction(hObject)

%
% check if map plot is active
%
h = findobj('Tag', 'MapPlot');
%
% update map plot
%
if ~isempty(h)
    
    kVIS_updateMap(hObject, h)
    
else
    %
    %  Plot the selected column of fdata.
    %
    handles=guidata(hObject);
    
    % Load signal data.
    [signal, signalMeta] = kVIS_fdsGetCurrentChannel(hObject);
    
    switch handles.uiTabDataViewer.AxesSelector
    case 'main_left'
        axes_handle = handles.uiTabDataViewer.axesBot;
        if size(axes_handle.YAxis,1) == 2
            yyaxis(axes_handle, 'left');
        end
    case 'main_right'
        axes_handle = handles.uiTabDataViewer.axesBot;
        yyaxis(axes_handle, 'right');
    case 'top'
        axes_handle = handles.uiTabDataViewer.axesTop;
    otherwise
        error('Invalid axes selected');
    end
    
    % plot the signal into the specified axes
    kVIS_plotSignal( ...
        hObject, ...
        signal, signalMeta, ...
        handles.uiFramework.holdToggle, ...
        axes_handle ...
        );
    
    evplot(hObject);

end



end



function evplot(hObject)

handles=guidata(hObject);

% event display testing
et = findobj('Tag','showEventsToggle');

if et.Value == 1
    
    if ~isempty(handles.uiTabDataViewer.showEvents)
        h = handles.uiTabDataViewer.showEvents;
        delete(h)
    end
    
    axes_handle = handles.uiTabDataViewer.axesBot;
    
    hold(axes_handle, 'on');
    
    ylim = kVIS_getDataRange(hObject, 'YlLim');
    
    
    fds = kVIS_getCurrentFds(hObject);
    
    eventList = fds.eventList;
    
    if isempty(eventList)
        disp('kVIS_dataViewerChannelListAction: event list empty...')
        return
    end
    
    for j = 1:size(eventList,2)
        
        % relate times to samples
        in = eventList(j).start;
        out= eventList(j).end;
        
        % create plot
        pg = polyshape([in out out in],[ylim(1) ylim(1) ylim(2) ylim(2)]);
        
        pp(j) = plot(axes_handle, pg, ...
            'EdgeColor','r',...
            'Facecolor','r',...
            'FaceAlpha',0.2);
    end
    
    handles.uiTabDataViewer.showEvents = pp;
    
    guidata(hObject, handles);
end

end