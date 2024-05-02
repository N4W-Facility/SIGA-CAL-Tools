function Write_ExecutionFile(FilePath, UserData)
% Función para escritura del Archivo de Ejecición - SIGA-CAL 2022
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
% Esta función escribe los parámetros del archivo de ejecución, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
% FilePath    [String]: Ruta del archivo txt de ejecución SIGA-CAL
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
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%  Archivo de ejecución en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Guardar Niombre de Scenario
fprintf(ID_File,'[NOMBRE DEL ESCENARIO]\n');
fprintf(ID_File,UserData.NameSce);
fprintf(ID_File,'\n\n');

%% Guardar Fecha de inicio de la simulación
fprintf(ID_File,'[FECHA DE INICIO DE LA SIMULACIÓN] Año Mes Día\n');
Y = num2str(year(UserData.StartDate));
M = num2str(month(UserData.StartDate));
D = num2str(day(UserData.StartDate));
fprintf(ID_File,[Y,' ',M,' ',D]);
fprintf(ID_File,'\n\n');

%% Guardar Fecha de finalización de Simulación
fprintf(ID_File,'[FECHA DE FINALIZACIÓN DE LA SIMULACIÓN] Año Mes Día\n');
Y = num2str(year(UserData.EndDate));
M = num2str(month(UserData.EndDate));
D = num2str(day(UserData.EndDate));
fprintf(ID_File,[Y,' ',M,' ',D]);
fprintf(ID_File,'\n\n');

%% Guardar Tamaño del paso temporal de Simulación en días
fprintf(ID_File,'[TAMAÑO DE PASO TEMPORAL DE SIMULACIÓN EN DÍAS]\n');
fprintf(ID_File,'%0.1f',UserData.dt);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Topología
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE TOPOLOGÍA]\n');
fprintf(ID_File,UserData.Topo);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Temperatura Mínima
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE TEMPERATURA MÍNIMA]\n');
fprintf(ID_File,UserData.Tmin);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Temperatura Máxima
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE TEMPERATURA MÁXIMA]\n');
fprintf(ID_File,UserData.Tmax);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Humedad Relativa
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE HUMEDAD RELATIVA]\n');
fprintf(ID_File,UserData.HR);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Radiación solar
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE RADIACIÓN SOLAR]\n');
fprintf(ID_File,UserData.RS);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de precipitación
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE PRECIPITACIÓN]\n');
fprintf(ID_File,UserData.P);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de viento zonal
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE VIENTO ZONAL]\n');
fprintf(ID_File,UserData.VZ);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de viento meridional
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE VIENTO MERIDIONAL]\n');
fprintf(ID_File,UserData.VM);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo dede caudal liquido descargado
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE CAUDAL LÍQUIDO DESCARGADO]\n');
fprintf(ID_File,UserData.Q_LD);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de caudal liquido captado
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE CAUDAL LÍQUIDO CAPTADO]\n');
fprintf(ID_File,UserData.Q_LC);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de series de tiempo de arcillas mezcladas
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE ARCILLAS MEZCLADAS EN DESCARGAS]\n');
fprintf(ID_File,UserData.Clay);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de series de timempo de limis mezcaldos
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE LIMOS MEZCLADAS EN DESCARGAS]\n');
fprintf(ID_File,UserData.Silt);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de series de tiempo de arenas mezcladas
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE ARENAS MEZCLADAS EN DESCARGAS]\n');
fprintf(ID_File,UserData.Sand);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de movimientos en masa
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE MOVIMIENTOS EN MASA]\n');
fprintf(ID_File,UserData.MM);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de factores de calibración
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE FACTORES DE CALIBRACIÓN]\n');
fprintf(ID_File,UserData.F_Cal);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de muestreador de resultados
fprintf(ID_File,'[NOMBRE DEL ARCHIVO MUESTREADOR DE RESULTADOS]\n');
fprintf(ID_File,UserData.Sampler);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de tiempo de tasas de restauración
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE TASAS DE RESTAURACIÓN]\n');
fprintf(ID_File,UserData.ResRate);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de puntos de vertimientos
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE PUNTOS DE VERTIMIENTO]\n');
fprintf(ID_File,UserData.Dumping);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de ciclos anuales de cargas difusas
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE CICLOS ANUALES DE CARGAS DIFUSAS]\n');
fprintf(ID_File,UserData.LoadCycle);
fprintf(ID_File,'\n\n');

%% Guardar tipo de ejecucion del modelo
fprintf(ID_File,'[TIPO DE EJECUCIÓN DEL MODELO]\n');
fprintf(ID_File,'%d',UserData.ExeType);
fprintf(ID_File,'\n\n');

%% Guardar tipo de ejecucion del modelo
fprintf(ID_File,'[EVALUAR MODELO GEOTÉCNICO]\n');
fprintf(ID_File,'%d',UserData.GeoExeType);

%% Cerrar Archivo
fclose(ID_File);
