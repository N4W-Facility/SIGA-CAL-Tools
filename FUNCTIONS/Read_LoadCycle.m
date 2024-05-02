function UserData = Read_LoadCycle(FilePath)
% Funci�n para lectura de archivo de ciclos de carga - SIGA-CAL 2022
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
% Esta funci�n lee el contenido del archivo de ciclos de carga siguiendo la 
% estructura definida en la versi�n SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% FilePath  [String]: Ruta del archivo txt de ciclos de carga SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% UserData  [Struct]: Estructura con los par�metros de SIGA-CAL
%   .NameVar        : Nombre de variables
%   .Pday           : N�mero de dias
%   .NCycle         : N�mero de ciclos
%   .dt             : Paso de tiempo
%   .Modelo         : Tipo de modelo
%   .CodeCycle      : C�digo de los ciclos
%   .Data           : Datos de ciclos de carga
%   .Date           : D�as de ciclos de carga (366)
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File  = fopen(FilePath,'r');

% Leer primera linea
LineText = char('Init while');

% Contador
i = 0;

try
    while ischar(LineText)
        % Leer nueva linea
        LineText    = fgetl(ID_File);  

        % Continuar si encuentra l�nea vacia
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
            % Nombre de variables
            UserData.NameVar    = LineText;
        elseif i == 2
            % N�mero de dias
            UserData.Pday       = str2double(LineText);
        elseif i == 3 
            % N�mero de ciclos
            UserData.NCycle     = str2double(LineText);
        elseif i == 4
            % Paso de tiempo
            UserData.dt         = str2double(LineText);
        elseif i == 5
            % Tipo de modelo
            UserData.Modelo     = LineText;
        elseif i == 6
            % Ciclos
            Tmp                 = strsplit(LineText,' ');
            UserData.CodeCycle  = cellfun(@str2num,Tmp(2:end));

            UserData.Data       = textscan(ID_File,['%f',repmat(' %f',1,length(UserData.CodeCycle))]);
            UserData.Date       = cell2mat(UserData.Data(:,1));
            UserData.Data       = cell2mat(UserData.Data(:,2:end));
            
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