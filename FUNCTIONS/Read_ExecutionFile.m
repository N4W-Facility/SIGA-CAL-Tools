function UserData = Read_ExecutionFile(FilePath)
% Función para lectura de Archivo de Ejecición - SIGA-CAL 2022
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
% Esta función lee los parámetros contenidos en el archivo de ejecución, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
% FilePath    [String]: Ruta del archivo txt de ejecución SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% UserData    [Struct]: Estructura con los parámetros de SIGA-CAL
%   .SceName          : Nombre del escenario
%   .StartDate        : Fecha de início de la simulación    
%   .EndDate          : Fecha de finalización de la simulación
%   .dt               : Paso de tiempo de la simulación (diario)
%   .Topo             : Nombre del archivo de la topología
%   .Tmin             : Nombre del archivo de series de tiempo de temperatura mínima
%   .Tmax             : Nombre del archivo de series de tiempo de temperatura máxima
%   .HR               : Nombre del archivo de series de tiempo de humedad relativa
%   .RS               : Nombre del archivo de series de tiempo de radiación solar
%   .P                : Nombre del archivo de series de tiempo de precipitación
%   .VZ               : Nombre del archivo de series de tiempo de viento zonal
%   .VM               : Nombre del archivo de series de tiempo de viento meridional
%   .Q_LD             : Nombre del archivo de caudal líquido descargado
%   .Q_LC             : Nombre del archivo de caudal líquido captado
%   .Clay             : Nombre del archivo de series de tiempo de arcillas
%   .Silt             : Nombre del archivo de series de tiempo de limos
%   .Sand             : Nombre del archivo de series de tiempo de arenas
%   .MM               : Nombre del archivo de movimientos en masa
%   .F_Cal            : Nombre del archivo de factores de calibración
%   .Sampler          : Nombre del archivo muestreador
%   .ResRate          : Nombre del archivo de tasas de restauración
%   .Dumping          : Nombre del archivo de puntos de vertimiento
%   .LoadClycle       : Nombre del archivo de ciclos de cargas difusas
%   .ExeType          : Tipo de ejecución del modelo
%   .GeoExeType       : Evaluar modelo geotécnico
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File     = fopen(FilePath,'r');

% Inicialización de lectura
LineText    = char('Init while');

% Contador
i = 0;

try
    while ischar(LineText)

        % Leer nueva linea
        LineText = fgetl(ID_File);    
        LineText = strrep(LineText,'.txt','');

        % Control para leer datos
        Status = logical(strfind(LineText,'['));
        if isempty(LineText), Status = true; end

        if Status
            continue
        else
            % Contador
            i = i + 1;
        end

        % TimeSeries Number
        if i == 1
            % Nombre del escenario
            UserData.SceName    = LineText;
        elseif i == 2
            % Fecha de inicio de la simulación
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);        
            UserData.StartDate   = datetime(Tmp);
        elseif i == 3
            % Fecha de finalización de la simulación
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);   
            UserData.EndDate    = datetime(Tmp);
        elseif i == 4
            % Paso de tiempo de la simulación (diario)
            UserData.dt         = str2double(LineText);
        elseif i == 5
            % Nombre del archivo de la topología
            UserData.Topo       = LineText;
        elseif i == 6
            % Nombre del archivo de series de tiempo de temperatura mínima
            UserData.Tmin       = LineText;
        elseif i == 7
            % Nombre del archivo de series de tiempo de temperatura máxima
            UserData.Tmax       = LineText;
        elseif i == 8
            % Nombre del archivo de series de tiempo de humedad relativa
            UserData.HR         = LineText;
        elseif i == 9
            % Nombre del archivo de series de tiempo de radiación solar
            UserData.RS         = LineText;
        elseif i == 10
            % Nombre del archivo de series de tiempo de precipitación
            UserData.P          = LineText;    
        elseif i == 11
            % Nombre del archivo de series de tiempo de viento zonal
            UserData.VZ         = LineText;
        elseif i == 12
            % Nombre del archivo de series de tiempo de viento meridional
            UserData.VM         = LineText;
        elseif i == 13
            % Nombre del archivo de caudal líquido descargado
            UserData.Q_LD       = LineText;
        elseif i == 14
            % Nombre del archivo de caudal líquido captado
            UserData.Q_LC       = LineText;
        elseif i == 15
            % Nombre del archivo de series de tiempo de arcillas
            UserData.Clay       = LineText;
        elseif i == 16
            % Nombre del archivo de series de tiempo de limos
            UserData.Silt       = LineText;
        elseif i == 17
            % Nombre del archivo de series de tiempo de arenas
            UserData.Sand       = LineText;
        elseif i == 18
            % Nombre del archivo de movimientos en masa
            UserData.MM         = LineText;
        elseif i == 19
            % Nombre del archivo de factores de calibración
            UserData.F_Cal      = LineText;
        elseif i == 20
            % Nombre del archivo muestreador
            UserData.Sampler    = LineText;
        elseif i == 21
            % Nombre del archivo de tasas de restauración
            UserData.ResRate    = LineText;
        elseif i == 22
            % Nombre del archivo de puntos de vertimiento
            UserData.Dumping    = LineText;
        elseif i == 23
            % Nombre del archivo de ciclos de cargas difusas
            UserData.LoadCycle  = LineText;
        elseif i == 24
            % Nombre del archivo de condiciones de frontera
            UserData.BoundaryC  = LineText;
        elseif i == 25
            % Tipo de ejecución del modelo
            UserData.ExeType    = str2double(LineText);
        elseif i == 26
            % Evaluar modelo geotécnico
            UserData.GeoExeType = logical(str2double(LineText));
            % Close File 
        elseif i == 27
            % Evaluar modelo geotécnico
            UserData.pHExeType  = logical(str2double(LineText));
            % Close File 
            fclose(ID_File);
            break
        end

    end

catch ME
    % Cerrar Archivo
    fclose(ID_File);
    
    % Mesaje de error
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
                            ME.stack(1).name, ME.stack(1).line, ME.message);
    errordlg( errorMessage )
    return
end
