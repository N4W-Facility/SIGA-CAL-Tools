function UserData = Read_MassMovements(FilePath)
% Función para lectura de archivo de movimientos en masa - SIGA-CAL 2022
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
% Esta función lee el contenido del archivo de movimientos en masa siguiendo
% la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% FilePath  [String]: Ruta del archivo txt de movimientos en masa SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% UserData    [Struct]: Estructura con datos de movimientos en masa
%   .N                : Número de movimientos en masa
%   .NoValue          : Valor de No-Data
%   .Data             : Datos de movimientos en masa
%
% -------------------------------------------------------------------------

%% Start Function
% Open File
ID_File = fopen(FilePath,'r');

% Read firt line
LineText = char('Init');

% Counter
i = 0;

try
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

        % Número de movimientos en masa o vertimientos
        if i == 1   
            UserData.N       = str2double(LineText);
        % Valor de No-Data
        elseif i == 2
            UserData.NoValue = str2double(LineText);        
        % Datos
        elseif i == 3
            % Almacenamiento
            UserData.Data = NaN(UserData.N,6);
            for j = 1:UserData.N
                % Leer nueva línea
                LineText = fgetl(ID_File);
                
                Tmp = strsplit(LineText,' ');
                UserData.Data(j,:) = cellfun(@str2num,Tmp);                
            end
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
