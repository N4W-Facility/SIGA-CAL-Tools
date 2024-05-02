function UserData = Aggregation_TimeSeries(UserData, Resolution, StaName)
% Funci�n para agregaci�n de series de tiempo - SIGA-CAL 2022
% -------------------------------------------------------------------------
% Matlab Version > R2018b 
% -------------------------------------------------------------------------
%                              INFORMATION
% -------------------------------------------------------------------------
% Author      : Jonathan Nogales Pimentel
% Email       : jonathan.nogales@tnc.org
%             : jonathannogales02@gmail.com
% Date        : November, 2020
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
% Esta funci�n permite realizar la agregaci�n temporal de una serie de 
% tiempo, haciendo uso de diferentes estad�sticos (media, suma, etc).
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% UserData  [Struct]
%   .Date   [n,1]   : Vector datetime de fechas
%   .Data   [n,1]   : Array de datos
% Resolution        : Resoluci�n de agregaci�n. Se permiten las
%                     siguientes opciones en formato char.
%                     - 'Mensual'
%                     - 'Anual'
%                     En formato n�merico se admiten valores mayores a
%                     cero.
% StaName           : Nombre del estad�stico de agregaci�n
%                     - 'Promedio'
%                     - 'Suma'
%                     - 'M�nimo'
%                     - 'M�ximo'
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% UserData  [Struct]
%   .Date   [n,1]   : Vector datetime de fechas agregadas
%   .Data   [n,1]   : Array de datos agregados
%
% -------------------------------------------------------------------------

%% Start Function
% Estad�sticos de agregaci�n
if strcmp(StaName,'Promedio')
    MyFun = @(x) mean(x,'omitnan');
elseif strcmp(StaName,'Suma')
    MyFun = @(x) sum(x,'omitnan');
elseif strcmp(StaName,'M�nimo')
    MyFun = @(x) min(x);
elseif strcmp(StaName,'M�ximo')
    MyFun = @(x) max(x);
end

if strcmp(Resolution,'Mensual') || strcmp(Resolution,'Anual')
    
    if strcmp(Resolution,'Mensual')
        Table_i = table(UserData.Date, UserData.Data, year(UserData.Date), month(UserData.Date), day(UserData.Date),...
        'VariableNames',{'Date','Value','Y','M','D'});

        Tmp     = table2array(varfun(MyFun,Table_i,'GroupingVariables',{'Y','M'},'InputVariable','Value'));
        Date    = datetime(Tmp(:,1), Tmp(:,2), Tmp(:,1)*0 + 1, Tmp(:,1)*0, Tmp(:,1)*0, Tmp(:,1)*0);
        Data    = Tmp(:,4:end);
    elseif strcmp(Resolution,'Anual')
        Table_i = table(UserData.Date, UserData.Data, year(UserData.Date), month(UserData.Date), day(UserData.Date),...
        'VariableNames',{'Date','Value','Y','M','D'});

        Tmp     = table2array(varfun(MyFun,Table_i,'GroupingVariables',{'Y'},'InputVariable','Value'));
        Date    = datetime(Tmp(:,1), Tmp(:,1)*0 + 1, Tmp(:,1)*0 + 1, Tmp(:,1)*0, Tmp(:,1)*0, Tmp(:,1)*0);
        Data    = Tmp(:,3:end);
    end
    
else
    if mod(UserData.Fil,Resolution) == 0
        Step    = floor(UserData.Fil/Resolution);
    else
        Step    = floor(UserData.Fil/Resolution) + 1;
    end

    % Read File
    Data = zeros(Step, UserData.Col);

    for i = 1:UserData.Col

        if mod(UserData.Fil,Resolution) == 0
            Step    = floor(UserData.Fil/Resolution);
            % Time Series - Tmp
            Tmp     = UserData.Data(:,i);
        else
            Step    = floor(UserData.Fil/Resolution) + 1;
            Tmp     = NaN(Step*Resolution, 1);
            Tmp(1:UserData.Fil) = UserData.Data(:,i);
        end

        % Reshape
        Tmp = reshape(Tmp,Resolution,[]);

        % Aggregation   
        Data(:,i) = MyFun(Tmp)';
    end
    Date = UserData.Date(1:Resolution:(Step*Resolution));    
end

% Fecha agregada
UserData.Date = Date;
% Datos agregados
UserData.Data = Data;

end
