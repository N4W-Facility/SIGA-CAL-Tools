function Delete_ControlBranch(src,event, app)
% Función para eliminación de nodos de tramos de control - SIGA-CAL 2022
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
% Esta función permite la interacción dinámica para la eliminación de tramos 
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
% elimina los nodos iniciales y finales del punto de control creados por el
% usuario
%
% -------------------------------------------------------------------------

%% Start Function
global Ax4 Ax5

% Leer punto de control de tabla
ControlBranch  = app.Table_ControlBranch.Data;
id = find(~isnan(cell2mat(ControlBranch(:,1))));
ControlBranch  = ControlBranch(id,:); 

% Encontrar punto incial de tramo de control seleccionado
CP_Select = event.IntersectionPoint(1:2);
dis = sqrt( (cell2mat(ControlBranch(:,1)) - CP_Select(1)).^2 + ...
            (cell2mat(ControlBranch(:,2)) - CP_Select(2)).^2);

id1 = find(dis < 1);

dis = sqrt( (cell2mat(ControlBranch(:,3)) - CP_Select(1)).^2 + ...
            (cell2mat(ControlBranch(:,4)) - CP_Select(2)).^2);  

id2 = find(dis < 1);

% Preguntar al usuario si desea eliminar el punto 
answer = questdlg(['Esta seguro que desea eliminar el tramo de control - ',...
                    ControlBranch{[id1, id2],5}],'Dessert Menu','Si','No','Si');

if strcmp(answer, 'Si')
    % Eliminar punto seleccionado
    ControlBranch([id1, id2],:) = [];
else
    return
end               

delete(Ax4)
delete(Ax5)

% Asignar puntos a la tabla de la app
Tmp = cell(100,5);
for i = 1:length(ControlBranch(:,1))
    Tmp(i,:) = ControlBranch(i,:);
end
app.Table_ControlBranch.Data = Tmp;

if isempty(ControlBranch)
    return
end
    
% -------------------------------------------------------------------
% Plot tramos de control iniciales
% -------------------------------------------------------------------
Xp = cell2mat(ControlBranch(:,1));
Yp = cell2mat(ControlBranch(:,2));
Ax4 = scatter(app.MapsMuestreo,Xp,Yp,20,'filled',...
    'MarkerEdgeColor',[0 .5 .5],...
    'MarkerFaceColor',[0 .5 .5],...
    'LineWidth',1.5,...
    "ButtonDownFcn",{@Delete_ControlBranch,app});

% -------------------------------------------------------------------
% Plot tramos de control finales
% -------------------------------------------------------------------
Xp = cell2mat(ControlBranch(:,3));
Yp = cell2mat(ControlBranch(:,4));
Ax5 = scatter(app.MapsMuestreo,Xp,Yp,20,'filled',...
    'MarkerEdgeColor',[0.9 .7 .2],...
    'MarkerFaceColor',[0.9 .7 .2],...
    'LineWidth',1.5,...
    "ButtonDownFcn",{@Delete_ControlBranch,app});

end