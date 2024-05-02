function Write_ExecutionFile(FilePath, UserData)
% Funci�n para escritura del Archivo de Ejecici�n - SIGA-CAL 2022
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
% Esta funci�n escribe los par�metros del archivo de ejecuci�n, 
% siguiendo la estructura definida en la versi�n SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
% FilePath    [String]: Ruta del archivo txt de ejecuci�n SIGA-CAL
% UserData    [Struct]: Estructura con los par�metros de SIGA-CAL
%   .SceName          : Nombre del escenario
%   .StartDate        : Fecha de in�cio de la simulaci�n    
%   .EndDate          : Fecha de finalizaci�n de la simulaci�n
%   .dt               : Paso de tiempo de la simulaci�n (diario)
%   .Topo             : Nombre del archivo de la topolog�a
%   .Tmin             : Nombre del archivo de series de tiempo de temperatura m�nima
%   .Tmax             : Nombre del archivo de series de tiempo de temperatura m�xima
%   .HR               : Nombre del archivo de series de tiempo de humedad relativa
%   .RS               : Nombre del archivo de series de tiempo de radiaci�n solar
%   .P                : Nombre del archivo de series de tiempo de precipitaci�n
%   .VZ               : Nombre del archivo de series de tiempo de viento zonal
%   .VM               : Nombre del archivo de series de tiempo de viento meridional
%   .Q_LD             : Nombre del archivo de caudal l�quido descargado
%   .Q_LC             : Nombre del archivo de caudal l�quido captado
%   .Clay             : Nombre del archivo de series de tiempo de arcillas
%   .Silt             : Nombre del archivo de series de tiempo de limos
%   .Sand             : Nombre del archivo de series de tiempo de arenas
%   .MM               : Nombre del archivo de movimientos en masa
%   .F_Cal            : Nombre del archivo de factores de calibraci�n
%   .Sampler          : Nombre del archivo muestreador
%   .ResRate          : Nombre del archivo de tasas de restauraci�n
%   .Dumping          : Nombre del archivo de puntos de vertimiento
%   .LoadClycle       : Nombre del archivo de ciclos de cargas difusas
%   .ExeType          : Tipo de ejecuci�n del modelo
%   .GeoExeType       : Evaluar modelo geot�cnico
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%  Archivo de ejecuci�n en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Guardar Niombre de Scenario
fprintf(ID_File,'[NOMBRE DEL ESCENARIO]\n');
fprintf(ID_File,UserData.NameSce);
fprintf(ID_File,'\n\n');

%% Guardar Fecha de inicio de la simulaci�n
fprintf(ID_File,'[FECHA DE INICIO DE LA SIMULACI�N] A�o Mes D�a\n');
Y = num2str(year(UserData.StartDate));
M = num2str(month(UserData.StartDate));
D = num2str(day(UserData.StartDate));
fprintf(ID_File,[Y,' ',M,' ',D]);
fprintf(ID_File,'\n\n');

%% Guardar Fecha de finalizaci�n de Simulaci�n
fprintf(ID_File,'[FECHA DE FINALIZACI�N DE LA SIMULACI�N] A�o Mes D�a\n');
Y = num2str(year(UserData.EndDate));
M = num2str(month(UserData.EndDate));
D = num2str(day(UserData.EndDate));
fprintf(ID_File,[Y,' ',M,' ',D]);
fprintf(ID_File,'\n\n');

%% Guardar Tama�o del paso temporal de Simulaci�n en d�as
fprintf(ID_File,'[TAMA�O DE PASO TEMPORAL DE SIMULACI�N EN D�AS]\n');
fprintf(ID_File,'%0.1f',UserData.dt);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Topolog�a
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE TOPOLOG�A]\n');
fprintf(ID_File,UserData.Topo);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Temperatura M�nima
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE TEMPERATURA M�NIMA]\n');
fprintf(ID_File,UserData.Tmin);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Temperatura M�xima
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE TEMPERATURA M�XIMA]\n');
fprintf(ID_File,UserData.Tmax);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Humedad Relativa
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE HUMEDAD RELATIVA]\n');
fprintf(ID_File,UserData.HR);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de Radiaci�n solar
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE RADIACI�N SOLAR]\n');
fprintf(ID_File,UserData.RS);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de precipitaci�n
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE PRECIPITACI�N]\n');
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
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE CAUDAL L�QUIDO DESCARGADO]\n');
fprintf(ID_File,UserData.Q_LD);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de caudal liquido captado
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE CAUDAL L�QUIDO CAPTADO]\n');
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

%% Guardar Nombre del Archivo de factores de calibraci�n
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE FACTORES DE CALIBRACI�N]\n');
fprintf(ID_File,UserData.F_Cal);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de muestreador de resultados
fprintf(ID_File,'[NOMBRE DEL ARCHIVO MUESTREADOR DE RESULTADOS]\n');
fprintf(ID_File,UserData.Sampler);
fprintf(ID_File,'\n\n');

%% Guardar Nombre del Archivo de tiempo de tasas de restauraci�n
fprintf(ID_File,'[NOMBRE DEL ARCHIVO DE SERIES DE TIEMPO DE TASAS DE RESTAURACI�N]\n');
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
fprintf(ID_File,'[TIPO DE EJECUCI�N DEL MODELO]\n');
fprintf(ID_File,'%d',UserData.ExeType);
fprintf(ID_File,'\n\n');

%% Guardar tipo de ejecucion del modelo
fprintf(ID_File,'[EVALUAR MODELO GEOT�CNICO]\n');
fprintf(ID_File,'%d',UserData.GeoExeType);

%% Cerrar Archivo
fclose(ID_File);
