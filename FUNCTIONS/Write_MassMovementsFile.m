function Write_MassMovementsFile(FilePath, UserData)
% Función para escritura del archivo de movimientos en masa - SIGA-CAL 2022
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
% Esta función escribe el contenido del archivo de movimientos en masa 
% siguiendo la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% FilePath  [String]: Ruta del archivo txt de movimientos en masa SIGA-CAL
% UserData    [Struct]: Estructura con datos de movimientos en masa
%   .N                : Número de movimientos en masa
%   .NoValue          : Valor de No-Data
%   .Data             : Datos de movimientos en masa
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% Archivo de movimientos en masa en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Numero de puntos de control
% Calcular numero de puntos de control
fprintf(ID_File,'[NÚMERO DE MOVIMIENTOS EN MASA]\n');
fprintf(ID_File,'%d\n',UserData.N);
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[VALOR DE DATOS FALTANTES]\n');
fprintf(ID_File,'%d\n',UserData.NoValue);
fprintf(ID_File,'\n');

%% Listado de puntos de control
fprintf(ID_File,'[MATRIZ DE DATOS]\n');
fprintf(ID_File,'Año Mes Dia X Y Area\n');
Data = UserData.Data;
fprintf(ID_File,['%d %d %d',repmat(' %f',1,3),'\n'],Data');

%% Cerrar Archivo
fclose(ID_File);