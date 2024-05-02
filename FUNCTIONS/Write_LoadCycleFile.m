function Write_LoadCycleFile(FilePath, UserData)
% Función para escritura del archivo de ciclos de carga - SIGA-CAL 2022
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
% Esta función escribe el contenido del archivo de ciclos de carga siguiendo 
% la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
% FilePath  [String]: Ruta del archivo txt de ciclos de carga SIGA-CAL
% UserData  [Struct]: Estructura con los parámetros de SIGA-CAL
%   .NameVar        : Nombre de variables
%   .Pday           : Número de dias
%   .NCycle         : Número de ciclos
%   .dt             : Paso de tiempo
%   .Modelo         : Tipo de modelo
%   .CodeCycle      : Código de los ciclos
%   .Data           : Datos de ciclos de carga
%   .Date           : Días de ciclos de carga (366)
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% Archivo de ciclos de carga en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Numero de puntos de control
% Calcular numero de puntos de control
fprintf(ID_File,'[VARIABLE]\n');
fprintf(ID_File,'Vertimientos\n');
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[PERIODO EN DÍAS DEL CICLO]\n');
fprintf(ID_File,'%d\n',UserData.Pday);
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[NÚMERO DE CICLOS REPRESENTADOS]\n');
fprintf(ID_File,'%d\n',UserData.NCycle);
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[RESOLUCIÓN TEMPORAL EN DÍAS]\n');
fprintf(ID_File,'%d\n',UserData.dt);
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[MODELO A PARTIR DE VARIBLE SECUNDARIA]\n');
fprintf(ID_File,'ninguno\n');
fprintf(ID_File,'\n');

%% Listado de puntos de control
Tmp = 'dia';
N = length(UserData.CodeCycle);
for i = 1:N
    Tmp = [Tmp,' ',num2str(UserData.CodeCycle(i))];
end
fprintf(ID_File,'[CICLO DE LA VARIABLE]\n');
fprintf(ID_File,'%s\n',Tmp); 
fprintf(ID_File,['%d',repmat(' %f',1,N),'\n'],[UserData.Date UserData.Data]');

%% Cerrar Archivo
fclose(ID_File);