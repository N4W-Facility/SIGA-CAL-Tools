function UserData = Read_CalibrationFile(FilePath,NoValue)
% Función para lectura de archivo de calibración - SIGA-CAL 2022
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
% Esta función lee los parámetros contenidos en el archivo de calibración, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
%   FilePath    [String]: Ruta del archivo txt de calibración SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%   UserData    [Struct]: Estructura con los parámetros de calibración
%     .Met              : Parámetros Meteorológicos
%     .Veg              : Parámetros de Restauración
%     .Fen              : Parámetros Fenológicos
%     .Hid              : Parámetros Hidrológicos
%     .Sed              : Parámetros Sedimentológicos
%     .Geo              : Parámetros Geotécnicos
%     .LoD              : Parámetros de aplicación de Cargas Difusas
%     .Tsa              : Parámetros de Temperatura del Suelo y Agua
%     .EsC              : Parámetros de Escherichia Coli
%     .Nit              : Parámetros de Nitrógeno
%     .Fos              : Parámetros de Fósforo
%     .DBO              : Parámetros de DBO-Carbonacea
%     .Air              : Parámetros de Reaireación
%     .CoT              : Parámetros de Coliformes Totales
%     .Tur              : Parámetros de Turbiedad
%     .CoE              : Parámetros de Conductividad Eléctrica
%     .SST              : Parámetros de Solidos Suspendidos Totales
%     .ADZ              : Parámetros de ADZ-QUASAR
%     .The              : Parámetros de Theta para correción de temperatura
%     .Tau              : Parámetros de rezagos temporales
%     .ICA              : Parámetros de ICA-EPM
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File  = fopen(FilePath,'r');

% Inicialización de lectura
LineText = char('Init while');

% Contador
i = 0;

% Almacenamiento
UserData.Veg    = [];
UserData.Fen    = [];
UserData.CaD    = [];

try
    while ischar(LineText)

        % Leer nueva linea
        LineText    = fgetl(ID_File);  

        % Continuar si encuentra línea vacia
        if isempty(LineText), continue; end

        % Control para leer datos
        Status      = logical(strfind(LineText,'['));    

        if Status
            % Lectura de emcabezado
            fgetl(ID_File); 
            % Lectura de dato 
            LineText    = fgetl(ID_File);
            % Contador
            i = i + 1;
        end        

        if i == 1
            % Numero de parámetros
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            UserData.n_rest  = Tmp(1);        
            UserData.n_feno  = Tmp(2);
            UserData.n_load  = Tmp(3);

        elseif i == 2        
            % Parametros del modelo meteorológico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Met = Tmp;

        elseif i == 3
            % Parametros del modelo de vegetación
            while ~isempty(LineText)            
                Tmp = strsplit(LineText,' ');
                Tmp = cellfun(@str2num,Tmp);
                Tmp(Tmp == NoValue) = NaN;
                UserData.Veg = [UserData.Veg; Tmp];
                % Leer nueva línea
                LineText = fgetl(ID_File);
            end

        elseif i == 4
            % Factores del modelo fenológico
            while ~isempty(LineText)
                Tmp = strsplit(LineText,' ');
                Tmp = cellfun(@str2num,Tmp);
                Tmp(Tmp == NoValue) = NaN;
                UserData.Fen = [UserData.Fen; Tmp];
                % Leer nueva línea
                LineText = fgetl(ID_File);
            end

        elseif i == 5
            % Factores del modelo hidrológico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Hid = Tmp;

        elseif i == 6
            % Factores del modelo sedimentológico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Sed = Tmp;

        elseif i == 7
            % Factores del modelo geotécnico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Geo = Tmp;

        elseif i == 8
            % Factores del apliación de cargas difusas            
            while ~isempty(LineText)            
                Tmp = strsplit(LineText,' ');
                Tmp = cellfun(@str2num,Tmp);
                Tmp(Tmp == NoValue) = NaN;
                UserData.CaD = [UserData.CaD; Tmp];
                % Leer nueva línea
                LineText = fgetl(ID_File);
            end

        elseif i == 9
            % Parámetros de rezagos temporales
            UserData.Tau = str2double(LineText);

        elseif i == 10
            % Parámetros DBO-Carbonacea
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.DBO = Tmp;

        elseif i == 11
            % Parámetros de Reaireación
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Air = Tmp;

        elseif i == 12
            % Parámetros de Escherichia Coli
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.EsC = Tmp;

        elseif i == 13
            % Parámetros de Nitrógeno
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Nit = Tmp;
        elseif i == 14
            % Parámetros de Fósforo
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Fos = Tmp;

        elseif i == 15
            % Parámetros de Coliformes Totales
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.CoT = Tmp;

        elseif i == 16
            % Parámetros de Turbiedad
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Tur = Tmp;

        elseif i == 17
            % Parámetros de Conductividad Eléctrica
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.CoE = Tmp;

        elseif i == 18
            % Parámetros de Solidos Suspendidos Totales
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.SST = Tmp;

        elseif i == 19
            % Parámetros de Theta para correción de temperatura
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.The = Tmp;

        elseif i == 20
            % Parámetros de Temperatura del Suelo y Agua
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Tsa = Tmp;

        elseif i == 21
            % Parámetros de ADZ-QUASAR
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.ADZ = Tmp;

        elseif i == 22
            % Parámetros ICA-EPM
            UserData.ICA = logical(str2double(LineText));
            
        elseif i == 23
            % Parámetros de pH
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.pH = Tmp;
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