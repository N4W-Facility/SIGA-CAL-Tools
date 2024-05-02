function UserData = Read_SamplerFile(FilePath)
% Función para lectura de archivo muestreador - SIGA-CAL 2022
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
% Esta función lee los parámetros contenidos en el archivo de muestreador, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
%  FilePath         [String]: Ruta del archivo txt de muestreador SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%  UserData         [Struct]: Estructura con los parámetros de SIGA-CAL
%   .N_CP                   : Numero de Puntos de Control
%   .Var_ControlPoints      : Listado de Variables para puntos de control   
%   .ControlPoints          : Listado de Puntos de control
%   .N_CB                   : Numero de Tramos de control
%   .Var_ControlBranch      : Listado de variables para tramos de control
%   .ControlBranch          : Listado de tramos de control
%   .Var_Map                : Listado de variables para mapas
%   .Var_Unit               : Unidades de varibles
%   .ConversionFactors      : Factores de conversión 
%   .Var_MapVarStream       : Listado de variables para mapas solo en cauce
%   .Var_MapVarStreamMask   : Listado de variables para enmascarar mapas de 
%                             cauce
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'r');

% Leer primera linea
LineText = char('Init while');

% Contador
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
            if (i~=0) && (i~=3)
                % Lectura de emcabezado
                fgetl(ID_File); 
                % Lectura de dato 
                LineText    = fgetl(ID_File);
            else
                % Lectura de dato 
                LineText    = fgetl(ID_File);
            end
            % Contador
            i = i + 1;
        end        

        if i == 1        
            % Numero de Puntos de Control
            UserData.N_CP   = str2double(LineText);

        elseif i == 2
            % Listado de Variables para puntos de control
            Tmp = strsplit(LineText,' ');
            UserData.Var_ControlPoints   = logical(cellfun(@str2num,Tmp));

        elseif i == 3
            % Listado de Puntos de control
            UserData.ControlPoints = cell(UserData.N_CP,4);       
            j = 1;
            while ~isempty(LineText)  
                Tmp     = strsplit(LineText,' ');
                Tmp{1}  = str2double(Tmp{1});
                Tmp{2}  = str2double(Tmp{2});
                UserData.ControlPoints(j,:) = Tmp;
                j = j + 1;
                % Leer nueva línea
                LineText = fgetl(ID_File);
            end

        elseif i == 4
            % Numero de Tramos de control
            UserData.N_CB    = str2double(LineText);

        elseif i == 5
            % Listado de variables para tramos de control
            Tmp = strsplit(LineText,' ');     
            UserData.Var_ControlBranch   = logical(cellfun(@str2num,Tmp));

        elseif i == 6
            % Listado de tramos de control
            UserData.ControlBranch = cell(UserData.N_CB,5);
            j = 1;
            while ~isempty(LineText)  
                Tmp     = strsplit(LineText,' ');
                Tmp{1}  = str2double(Tmp{1});
                Tmp{2}  = str2double(Tmp{2});
                Tmp{3}  = str2double(Tmp{3});
                Tmp{4}  = str2double(Tmp{4});
                UserData.ControlBranch(j,:) = Tmp;
                j = j + 1;
                % Leer nueva línea
                LineText = fgetl(ID_File);                
            end

        elseif i == 7
            % Listado de variables para mapas
            Tmp = strsplit(LineText,' ');
            UserData.Var_Map   = logical(cellfun(@str2num,Tmp));

        elseif i == 8
            % Se omite

        elseif i == 9
            % Unidades de varibles  
            UserData.Var_Unit   = strsplit(LineText,' ');

        elseif i == 10
            % Factores de conversión            
            UserData.ConversionFactors     = cellfun(@str2num,strsplit(LineText,' ')); 

        elseif i == 11
            % Listado de variables para mapas solo en cauce
            Tmp = strsplit(LineText,' ');
            UserData.Var_MapVarStream = logical(cellfun(@str2num,Tmp));

        elseif i == 12
            % Listado de variables para enmascarar mapas de cauce
            Tmp = strsplit(LineText,' ');
            UserData.Var_MapVarStreamMask = logical(cellfun(@str2num,Tmp));
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