function Create_ControlBranch_End(src,event, app)
% Función para creación de nodo final de tramos de control - SIGA-CAL 2022
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
% Esta función permite la interacción dinámica para la creación de tramos 
% de control (nodo final) en el mapa de muestreador del módulo de 
% configuración.
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
% Gráfico de nodo final del tramo de control
%
% -------------------------------------------------------------------------

%% Start Function
global Ax4 Ax5 Ax6 UserDataTopo

% Leer punto de control de tabla
ControlBranch  = app.Table_ControlBranch.Data;
id = find(~isnan(cell2mat(ControlBranch(:,1))));
ControlBranch  = ControlBranch(id,:); 

% Solicitar nombre del tramo de control
prompt      = {'Ingrese nombre del tramo de control:'};
dlgtitle    = 'Tramo de Control';
dims        = [1 45];
definput    = {['Branch_Points_', num2str(length(ControlBranch(:,1)))]};
NameBranch  = inputdlg(prompt,dlgtitle,dims,definput);

if isempty(NameBranch)
    return
end

% Encontrar punto de control seleccionado
CB = event.IntersectionPoint(1:2);

% Asignar puntos a la tabla de la app
Tmp = cell(100,5);
for i = 1:length(ControlBranch(:,1))
    Tmp(i,:) = ControlBranch(i,:);
end
if length(ControlBranch(:,1)) == 0
    i = 0;
end
Tmp(i,:) = {Tmp{i,1},Tmp{i,2},CB(1),CB(2),NameBranch{:}};
app.Table_ControlBranch.Data = Tmp;

% Leer punto de control de tabla
ControlBranch  = app.Table_ControlBranch.Data;
id = find(~isnan(cell2mat(ControlBranch(:,1))));
ControlBranch  = ControlBranch(id,:); 

delete(Ax4)
delete(Ax5)
delete(Ax6)   

% Plot points network            
Ax6 = scatter(app.MapsMuestreo,UserDataTopo.X(UserDataTopo.Stream),...
            UserDataTopo.Y(UserDataTopo.Stream),10,'filled',...
            'MarkerEdgeColor',[0.9 1.0 0],...
            'MarkerFaceColor',[0.9 1.0 0],...                    
            "ButtonDownFcn",{@Create_ControlBranch_Start,app});            

% Plot de tramos y puntos de control 
app.Plot_ControlBranch_Start; 
app.Plot_ControlBranch_End; 

 % Selección de punto inicial
answer = questdlg('Seleccione el punto inicial del nuevo tramo de control', ...
                    'Dessert Menu','Ok','Ok');
                
end