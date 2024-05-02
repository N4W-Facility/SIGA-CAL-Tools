function UserData = Read_TimeSeries_SIGA(FilePath)
% Función para lectura de series de tiempo de entrada de SIGA-CAL 2022
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
% Esta función lee el contenido de los archivos de series de tiempo de 
% entrada siguiendo la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% FilePath  [String]: Ruta del archivo txt de serie de tiempo SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% UserData  [Struct]: Estructura de series de tiempo SIGA-CAL
%     .Col          : Cantidad de estaciones
%     .Fil          : Cantidad de dias 
%     .NoValue      : Valores NoData
%     .X            : Coordenadas este
%     .Y            : Coordenadas norte
%     .Z            : Elevación
%     .NameVar      : Nombre o código de las estaciones
%     .Data         : Datos de las estaciones
%     .Date         : Fecha de los registros
%
% -------------------------------------------------------------------------

%% Start Function
% Open File
ID_File = fopen(FilePath,'r');

% Read firt line
LineText = char('Init');

% Counter
i = 0;

while ischar(LineText)
    % Leer nueva linea
    LineText    = fgetl(ID_File);  

    % Continuar si encuentra línea vacia
    if isempty(LineText), continue; end

    % Control para leer datos
    Status      = logical(strfind(LineText,'['));    

    if Status
        % Lectura de dato 
        LineText    = fgetl(ID_File);
        % Contador
        i = i + 1;
    end        
   
    % TimeSeries Number
    if i == 1
        UserData.Col     = str2double(LineText);
    % Date Number
    elseif i == 2
        UserData.Fil     = str2double(LineText); 
    % Read NaN-Value
    elseif i == 3
        UserData.NoValue = str2double(LineText);        
    % Coordinates - X
    elseif i == 4
        Tmp             = strsplit(LineText,' ');
        Tmp             = cellfun(@str2double, Tmp);
        UserData.X      = Tmp;        
    % Coordinates - Y
    elseif i == 5
        Tmp             = strsplit(LineText,' ');
        Tmp             = cellfun(@str2double, Tmp);
        UserData.Y      = Tmp;
    % Coordinates - Z
    elseif i == 6
        Tmp             = strsplit(LineText,' ');
        Tmp             = cellfun(@str2double, Tmp);
        UserData.Z      = Tmp;
    elseif i == 7
        Tmp             = strsplit(LineText,' ');
        UserData.NameVar = cellfun(@str2num,Tmp(4:end));
        
        UserData.Data    = textscan(ID_File,['%f',repmat('%f',1,UserData.Col + 2)],'Delimiter',' ');
        UserData.Data    = cell2mat(UserData.Data);
        % Date
        UserData.Date    = datetime(UserData.Data(:,1:3));
        % Data
        UserData.Data    = UserData.Data(:,4:end);
        % Close File 
        fclose(ID_File);
        break
    end
end

% NaN
UserData.Data(UserData.Data==UserData.NoValue) = NaN;

end
