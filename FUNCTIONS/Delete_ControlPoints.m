function Delete_ControlPoints(src,event, app)
% Función para eliminación de puntos de control - SIGA-CAL 2022
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
% Esta función permite la interacción dinámica para la eliminación de puntos 
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
% Elimina los punto de control seleccionados por el usuario
%
% -------------------------------------------------------------------------

%% Start Function
global Ax3

% Leer punto de control de tabla
ControlPoints = app.Table_ControlPoint.Data;
id = find(~isnan(cell2mat(ControlPoints(:,1))));
ControlPoints = ControlPoints(id,:);

% Encontrar punto de control seleccionado
CP_Select = event.IntersectionPoint(1:2);
dis = sqrt( (cell2mat(ControlPoints(:,1)) - CP_Select(1)).^2 + ...
      (cell2mat(ControlPoints(:,2)) - CP_Select(2)).^2);
id = find(dis == min(dis));

% Preguntar al usuario si desea eliminar el punto 
answer = questdlg(['Esta seguro que desea eliminar el punto de control - ',...
                    ControlPoints{id,3}],'Dessert Menu','Si','No','Si');

if strcmp(answer, 'Si')
    % Eliminar punto seleccionado
    ControlPoints(id,:) = [];
else
    return
end  

delete(Ax3)

% Asignar puntos a la tabla de la app
Tmp = cell(100,4);
for i = 1:length(ControlPoints(:,1))
    Tmp(i,:) = ControlPoints(i,:);
end
app.Table_ControlPoint.Data = Tmp;

if isempty(ControlPoints)
    return
end

% Plot puntos de control restantes
Xp = cell2mat(ControlPoints(:,1));
Yp = cell2mat(ControlPoints(:,2));
Ax3 = scatter(app.MapsMuestreo,Xp,Yp,20,'filled',...
        'MarkerEdgeColor',[0.5882 0 0.0941],...
        'MarkerFaceColor',[0.5882 0 0.0941],...
        'LineWidth',1.5,...
        "ButtonDownFcn",{@Delete_ControlPoints,app});

