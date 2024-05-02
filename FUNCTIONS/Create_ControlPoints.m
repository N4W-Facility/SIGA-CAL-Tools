function Create_ControlPoints(src,event, app)
% Función para creación de puntos de control - SIGA-CAL 2022
% -------------------------------------------------------------------------
% Matlab Version > R2019b 
% -------------------------------------------------------------------------
%                              INFORMATION
% -------------------------------------------------------------------------
% Author      : Jonathan Nogales Pimentel
% Email       : jonathan.nogales@tnc.org
%             : jonathannogales02@gmail.com
% Date        : Junio, 2022
% 
% -------------------------------------------------------------------------
% This program is free software: you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the 
% Free Software Foundation, either version 3 of the License, or option) any 
% later version. This program is distributed in the hope that it will be 
% useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
% ee the GNU General Public License for more details. You should have 
% received a copy of the GNU General Public License along with this program
% If not, see http://www.gnu.org/licenses/.
%
% -------------------------------------------------------------------------
%                               DESCRIPTION 
% -------------------------------------------------------------------------
% Esta función permite la interacción dinámica para la creación de puntos 
% de control en el mapa de muestreador del módulo de configuración.
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
% src   [objeto] : Objeto para llamdo de funciones en el gráfico
% event [Struct] : Datos del punto seleccionado por el usuario
% app   [app]    : Estructura de app
% 
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% Gráfico de punto de control
%
% -------------------------------------------------------------------------

%% Start Function
global Ax3

% Leer punto de control de tabla
ControlPoints = app.Table_ControlPoint.Data;
id = find(~isnan(cell2mat(ControlPoints(:,1))));
ControlPoints = ControlPoints(id,:);

% Solicitar nombre del punto
prompt = {'Ingrese nombre del punto de control:'};
dlgtitle = 'Puntos de Control';
dims = [1 45];
definput = {['Control_Points_', num2str(length(ControlPoints(:,1)) + 1)]};
% Check Errors
NamePoints = inputdlg(prompt,dlgtitle,dims,definput);

if isempty(NamePoints)
    return
end

% Solicitar estadísitico
list = {'valor','media'};
[id,Status] = listdlg('PromptString',{'Seleccione estadístico',''},...
    'SelectionMode','single','ListString',list,'ListSize',[200,60]);
if Status
    StaPoints = list{id};
else
    return
end

% Encontrar punto de control seleccionado
CP = event.IntersectionPoint(1:2);

% Asignar puntos a la tabla de la app
Tmp = cell(100,4);
for i = 1:length(ControlPoints(:,1))
    Tmp(i,:) = ControlPoints(i,:);
end

if length(ControlPoints(:,1)) == 0
    i = 0;
end
Tmp(i+1,:) = {CP(1),CP(2),NamePoints{1},StaPoints};
app.Table_ControlPoint.Data = Tmp;

% Leer punto de control de tabla
ControlPoints = app.Table_ControlPoint.Data;
id = find(~isnan(cell2mat(ControlPoints(:,1))));
ControlPoints = ControlPoints(id,:);

delete(Ax3)

% Plot de tramos y puntos de control 
app.Plot_ControlPoints; 