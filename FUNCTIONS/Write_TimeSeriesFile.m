function Write_TimeSeriesFile(FilePath, UserData)
% Función para escritura de series de tiempo de SIGA-CAL 2022
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
% Esta función escribe el contenido de los archivos de series de tiempo de 
% entrada y salida siguiendo la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% FilePath  [String]: Ruta del archivo txt de serie de tiempo SIGA-CAL
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
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% Archivo de serie de tiempo en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Número de series de tiempo
fprintf(ID_File,'[NÚMERO DE SERIES]\n');
fprintf(ID_File,'%d\n',UserData.Col);
fprintf(ID_File,'\n');

%% Número de dias de las series de timepo
fprintf(ID_File,'[NÚMERO DE SERIES]\n');
fprintf(ID_File,'%d\n',UserData.Fil);
fprintf(ID_File,'\n');

%% Valores no Value
fprintf(ID_File,'[VALOR DE DATOS FALTANTES]\n');
fprintf(ID_File,'%d\n',UserData.NoValue);
fprintf(ID_File,'\n');

%% Coordenadas X
fprintf(ID_File,'[COORDENADAS X]\n');
fprintf(ID_File,['%f',repmat(' %f',1,length(UserData.X)-1),'\n'],UserData.X);
fprintf(ID_File,'\n');

%% Coordenadas X
fprintf(ID_File,'[COORDENADAS Y]\n');
fprintf(ID_File,['%f',repmat(' %f',1,length(UserData.Y)-1),'\n'],UserData.Y);
fprintf(ID_File,'\n');

%% Coordenadas X
fprintf(ID_File,'[COORDENADAS Z]\n');
fprintf(ID_File,['%f',repmat(' %f',1,length(UserData.Z)-1),'\n'],UserData.Z);
fprintf(ID_File,'\n');

%% Listado de puntos de control
Tmp = 'Año Mes Dia';
for i = 1:length(UserData.NameVar)
    Tmp = [Tmp,' ',num2str(UserData.NameVar(i))];
end
fprintf(ID_File,'[MATRIZ DE DATOS]\n');
fprintf(ID_File,'%s\n',Tmp);
Data = [year(UserData.Date) month(UserData.Date) day(UserData.Date) UserData.Data];
fprintf(ID_File,['%d %d %d',repmat(' %f',1,length(UserData.Z)),'\n'],Data');

%% Cerrar Archivo
fclose(ID_File);