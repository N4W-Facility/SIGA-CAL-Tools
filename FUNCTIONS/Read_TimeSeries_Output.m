function Results = Read_TimeSeries_Output(NameFile)
% Función para lectura de series de tiempo de salida de SIGA-CAL 2022
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
% salida siguiendo la estructura definida en la versión SIGA-CAL
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
%     .Col          : Cantidad de variables
%     .Fil          : Cantidad de dias 
%     .NoValue      : Valores NoData
%     .X            : Coordenadas este
%     .Y            : Coordenadas norte
%     .Z            : Elevación
%     .NameVar      : Nombre o código de las variables
%     .Data         : Datos de las variables
%     .Date         : Fecha de los registros
%
% -------------------------------------------------------------------------

%% Start Function
% Open File
ID_File = fopen(NameFile,'r');

% Read firt line
LineText = char('Init');

% Counter
i = 1;

while ischar(LineText)
    % Read New Line
    LineText = fgetl(ID_File);    
    % TimeSeries Number
    if i == 2
        Results.Col     = str2double(LineText);
    % Date Number
    elseif i == 5
        Results.Fil     = str2double(LineText); 
    % Read NaN-Value
    elseif i == 8
        Results.NoValue = str2double(LineText);        
    % Coordinates - X
    elseif i == 11
        Tmp             = strsplit(LineText,' ');
        Tmp             = cellfun(@str2double, Tmp);
        Results.X       = Tmp;        
    % Coordinates - Y
    elseif i == 14
        Tmp             = strsplit(LineText,' ');
        Tmp             = cellfun(@str2double, Tmp);
        Results.Y       = Tmp;
    % Coordinates - Z
    elseif i == 17
        Tmp             = strsplit(LineText,' ');
        Tmp             = cellfun(@str2double, Tmp);
        Results.Z       = Tmp;
    elseif i == 20
        Tmp             = strsplit(LineText,' ');
        Results.NameVar = Tmp(4:end)';
        
        Results.Data    = textscan(ID_File,['%f',repmat(' %f',1,Results.Col + 2)]);
        Results.Data    = cell2mat(Results.Data);
        % Date
        Results.Date    = datetime(Results.Data(:,1:3));
        % Data
        Results.Data    = Results.Data(:,4:end);
    end
    
    % Counter
    i = i + 1;
end

% NaN
Results.Data(Results.Data==Results.NoValue) = NaN;

% Close File 
fclose(ID_File);

end
