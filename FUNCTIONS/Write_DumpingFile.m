function Write_DumpingFile(FilePath, UserData)
% Función para escritura de archivo de vertimientos - SIGA-CAL 2022
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
% Esta función escribe los parámetros del archivo de vertimientos, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
% FilePath    [String]: Ruta del archivo txt de vertimientos SIGA-CAL
% UserData    [Struct]: Estructura con datos de vertimientos
%   .N                : Número de  vertimientos
%   .NoValue          : Valor de No-Data
%   .Data             : Datos de vertimientos
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% Archivo de vertimientos en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Numero de puntos de control
% Calcular numero de puntos de control
fprintf(ID_File,'[NÚMERO DE PUNTOS]\n');
fprintf(ID_File,'%d\n',UserData.N);
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[VALOR DE DATOS FALTANTES]\n');
fprintf(ID_File,'%d\n',UserData.NoValue);
fprintf(ID_File,'\n');

%% Listado de puntos de control
fprintf(ID_File,'[MATRIZ DE DATOS]\n');
fprintf(ID_File,'Nombre X Y Q T SST NO3 NH4 NO CT EC alk pH OD CDBO5 CE PO PI\n');
Name = UserData.Data(:,1);
Data = cell2mat(UserData.Data(:,2:end));
Data = [Data(:,1:11) repmat(UserData.NoValue,UserData.N,2) Data(:,12:end)];
for i = 1:UserData.N      
    fprintf(ID_File,'%s ',Name{i});
    fprintf(ID_File,['%f',repmat(' %f',1,16)],Data(i,:));
    fprintf(ID_File,'\n');
end
fprintf(ID_File,'\n');

%% Cerrar Archivo
fclose(ID_File);