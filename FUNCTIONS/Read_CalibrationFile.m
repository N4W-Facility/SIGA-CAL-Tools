function UserData = Read_CalibrationFile(FilePath,NoValue)
% Funci�n para lectura de archivo de calibraci�n - SIGA-CAL 2022
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
% Esta funci�n lee los par�metros contenidos en el archivo de calibraci�n, 
% siguiendo la estructura definida en la versi�n SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
%   FilePath    [String]: Ruta del archivo txt de calibraci�n SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%   UserData    [Struct]: Estructura con los par�metros de calibraci�n
%     .Met              : Par�metros Meteorol�gicos
%     .Veg              : Par�metros de Restauraci�n
%     .Fen              : Par�metros Fenol�gicos
%     .Hid              : Par�metros Hidrol�gicos
%     .Sed              : Par�metros Sedimentol�gicos
%     .Geo              : Par�metros Geot�cnicos
%     .LoD              : Par�metros de aplicaci�n de Cargas Difusas
%     .Tsa              : Par�metros de Temperatura del Suelo y Agua
%     .EsC              : Par�metros de Escherichia Coli
%     .Nit              : Par�metros de Nitr�geno
%     .Fos              : Par�metros de F�sforo
%     .DBO              : Par�metros de DBO-Carbonacea
%     .Air              : Par�metros de Reaireaci�n
%     .CoT              : Par�metros de Coliformes Totales
%     .Tur              : Par�metros de Turbiedad
%     .CoE              : Par�metros de Conductividad El�ctrica
%     .SST              : Par�metros de Solidos Suspendidos Totales
%     .ADZ              : Par�metros de ADZ-QUASAR
%     .The              : Par�metros de Theta para correci�n de temperatura
%     .Tau              : Par�metros de rezagos temporales
%     .ICA              : Par�metros de ICA-EPM
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File  = fopen(FilePath,'r');

% Inicializaci�n de lectura
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

        % Continuar si encuentra l�nea vacia
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
            % Numero de par�metros
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            UserData.n_rest  = Tmp(1);        
            UserData.n_feno  = Tmp(2);
            UserData.n_load  = Tmp(3);

        elseif i == 2        
            % Parametros del modelo meteorol�gico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Met = Tmp;

        elseif i == 3
            % Parametros del modelo de vegetaci�n
            while ~isempty(LineText)            
                Tmp = strsplit(LineText,' ');
                Tmp = cellfun(@str2num,Tmp);
                Tmp(Tmp == NoValue) = NaN;
                UserData.Veg = [UserData.Veg; Tmp];
                % Leer nueva l�nea
                LineText = fgetl(ID_File);
            end

        elseif i == 4
            % Factores del modelo fenol�gico
            while ~isempty(LineText)
                Tmp = strsplit(LineText,' ');
                Tmp = cellfun(@str2num,Tmp);
                Tmp(Tmp == NoValue) = NaN;
                UserData.Fen = [UserData.Fen; Tmp];
                % Leer nueva l�nea
                LineText = fgetl(ID_File);
            end

        elseif i == 5
            % Factores del modelo hidrol�gico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Hid = Tmp;

        elseif i == 6
            % Factores del modelo sedimentol�gico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Sed = Tmp;

        elseif i == 7
            % Factores del modelo geot�cnico
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Geo = Tmp;

        elseif i == 8
            % Factores del apliaci�n de cargas difusas            
            while ~isempty(LineText)            
                Tmp = strsplit(LineText,' ');
                Tmp = cellfun(@str2num,Tmp);
                Tmp(Tmp == NoValue) = NaN;
                UserData.CaD = [UserData.CaD; Tmp];
                % Leer nueva l�nea
                LineText = fgetl(ID_File);
            end

        elseif i == 9
            % Par�metros de rezagos temporales
            UserData.Tau = str2double(LineText);

        elseif i == 10
            % Par�metros DBO-Carbonacea
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.DBO = Tmp;

        elseif i == 11
            % Par�metros de Reaireaci�n
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Air = Tmp;

        elseif i == 12
            % Par�metros de Escherichia Coli
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.EsC = Tmp;

        elseif i == 13
            % Par�metros de Nitr�geno
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Nit = Tmp;
        elseif i == 14
            % Par�metros de F�sforo
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Fos = Tmp;

        elseif i == 15
            % Par�metros de Coliformes Totales
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.CoT = Tmp;

        elseif i == 16
            % Par�metros de Turbiedad
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Tur = Tmp;

        elseif i == 17
            % Par�metros de Conductividad El�ctrica
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.CoE = Tmp;

        elseif i == 18
            % Par�metros de Solidos Suspendidos Totales
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.SST = Tmp;

        elseif i == 19
            % Par�metros de Theta para correci�n de temperatura
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.The = Tmp;

        elseif i == 20
            % Par�metros de Temperatura del Suelo y Agua
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.Tsa = Tmp;

        elseif i == 21
            % Par�metros de ADZ-QUASAR
            Tmp = strsplit(LineText,' ');
            Tmp = cellfun(@str2num,Tmp);
            Tmp(Tmp == NoValue) = NaN;
            UserData.ADZ = Tmp;

        elseif i == 22
            % Par�metros ICA-EPM
            UserData.ICA = logical(str2double(LineText));
            
        elseif i == 23
            % Par�metros de pH
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