function Plot_TimeSeries(src,event,app,UserData,NameVar)
% Función para gráfico interactivo de series de tiempo - SIGA-CAL 2022
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
global ID_Gauges

% Identificar estación seleccionada
Gauges_Select = event.IntersectionPoint(1:2);
dis = sqrt( (UserData.X - Gauges_Select(1)).^2 + ...
      (UserData.Y - Gauges_Select(2)).^2);
ID_Gauges = find(dis == min(dis));
ID_Gauges = ID_Gauges(1);

% Plot Time Series
plot(app.Plot_TimeSeries, UserData.Date, UserData.Data(:,ID_Gauges))
xlabel(app.Plot_TimeSeries,'Tiempo (d\''ias)', 'interpreter','latex', 'Fontsize',18)
ylabel(app.Plot_TimeSeries,NameVar,'interpreter','latex','Fontsize',18)
title(app.Plot_TimeSeries,['Estaci\''on - ',num2str(UserData.NameVar(ID_Gauges))],'interpreter','latex','Fontsize',18)
set(app.Plot_TimeSeries,'TickLabelInterpreter','latex','FontWeight','bold','Color','none','box','on','FontSize',15)
                
% Mostrar datos
Data = table(UserData.Date, UserData.Data(:,ID_Gauges),'VariableNames',{'Fecha','Valor'});
app.Table_Series.Data = Data;

