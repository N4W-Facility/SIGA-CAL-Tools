PathProject = 'C:\Users\TNC\Box\TNC-WaterFaciliy-ColGroup\04-Tecnico\01-CuencaVerde_Medellin_FY22\04-Carpetas-Trabajo\01-SIGA\DataStruct-SIGA-CAL';

%% Archivos de ejecución 
% % Lectura de archivo de Ejecución - Ok
% FilePath = fullfile(PathProject,'entradas','ejecucion','ejecucion_SIGA2022.txt');
% UserData = Read_ExecutionFile(FilePath);
% 
% % Escritura de archivo de Ejecución - Ok
% FilePath = fullfile(PathProject,'entradas','ejecucion','Tester_ejecucion_SIGA2022.txt');
% Write_ExecutionFile(FilePath, UserData);


%% Archivo de parametros 
% Lectura de archivo de Parámetros de Calibración - Ok
FilePath = fullfile(PathProject,'entradas','calibracion','factores_calibracion_SIGA2022.txt');
UserData = Read_CalibrationFile(FilePath);

% Escritura de archivo de Parámetros de Calibración - Ok
FilePath = fullfile(PathProject,'entradas','calibracion','Tester_factores_calibracion_SIGA2022.txt');
Write_CalibrationFile(FilePath, UserData);


return

%% Función - Lectura de archivo de Ciclos de Carga - Ok
FilePath = fullfile(PathProject,'entradas','ciclos','ciclo_anual_cargasdifusas_SIGA2022.txt');
UserData = Read_LoadCycle(FilePath);

%% Función - Lectura de archivo de Movimientos en Masa - Ok
FilePath = fullfile(PathProject,'entradas','movmasa','MovimientosMasa.txt');
UserData = Read_MassMovements(FilePath);

%% Función - Lectura de archivo de Muestreador - Ok
FilePath = fullfile(PathProject,'entradas','muestras','muestreador_SIGA2022.txt');
UserData = Read_SamplerFile(FilePath);

%% Función - Lectura de archivo de Muestreador - Ok
FilePath = fullfile(PathProject,'entradas','series','series_HR.txt');
UserData = Read_TimeSeries_SIGA(FilePath);