function Write_SamplerFile(FilePath, UserData)
% Función para escritura de archivo muestreador - SIGA-CAL 2022
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
% Esta función escribe los parámetros contenidos en el archivo de muestreador, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
% -------------------------------------------------------------------------
%                               INPUT DATA 
% -------------------------------------------------------------------------
%  FilePath         [String]: Ruta del archivo txt de muestreador SIGA-CAL
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
%   .Var_MapVarStreamMask   : Listado de variables para enmascarar mapas de cauce
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%   Archivo muestreador en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Parametros
NameVar = ['TA TAmin TAmax TAran TS TW HR RS PVer U Ux Uy LCL LWC EV ETo ',...
           'SMI HU LAI psi theta ks n2v n2 C_usle ETP PHor DTRjo LAIjo ',...
           'LAIopt S0 S1 S2 S3 S4 S5 E0 E1 E2 E3 E4 E5 I0 I1 I2 I3 I4 O4 ',...
           'U2 U3 U4 U5 AF3 Q2 Q5 Q5a Q5c Q5d Q5p H2 H5 H5b W5 W5b P5 A5 ',...
           'R5 D5 n5l n5b n5 arcS2S limS2S areS2S arcS2D limS2D areS2D ',...
           'arcS5S limS5S areS5S arcS5D limS5D areS5D arcE2S limE2S areE2S ',...
           'arcE2D limE2D areE2D arcE2E limE2E areE2E arcE5S limE5S areE5S ',...
           'arcE5D limE5D areE5D arcE5E limE5E areE5E E2Smax E2Dmax ',...
           'arcE5Smax limE5Smax areE5Smax arcI2D limI2D areI2D arcI5D ',...
           'limI5D areI5D ER5b PRx Lx Fx EntSed SalSed EST EDT E2ET E5ET ',...
           'EET ESDET Zw arcDV limDV areDV PFB S0EC S1ECp S1ECs S2EC S3EC ',...
           'S4EC S0NO S1NOp S1NOs S2NO S3NO S4NO S0NH4 S1NH4p S1NH4s S2NH4 ',...
           'S3NH4 S4NH4 S0NO3 S1NO3p S1NO3s S2NO3 S3NO3 S4NO3 S0PO S1POp ',...
           'S1POs S2PO S3PO S4PO S0PI S1PIp S1PIs S2PI S3PI S4PI S0PO_fb ',...
           'S1POp_fb S1POs_fb S2PO_fb S3PO_fb S0PI_fb S1PIp_fb S1PIs_fb ',...
           'S2PI_fb S3PI_fb QEC QNO3 QNH4 QNO QPO QPI I1EC I2EC I3EC I4EC ',...
           'E2EC E3EC S0NO_miner S1NOp_miner S1NOs_miner S2NO_miner ',...
           'S3NO_miner I1NO I2NO I3NO I4NO E2NO E3NO E4NO I1NO3 I2NO3 ',...
           'I3NO3 I4NO3 E2NO3 E3NO3 E4NO3 S0NH4_nitri S1NH4p_nitri ',...
           'S1NH4s_nitri S2NH4_nitri S3NH4_nitri I1NH4 I2NH4 I3NH4 I4NH4 ',...
           'E2NH4 E3NH4 E4NH4 I1PO I2PO I3PO I4PO E2PO E3PO E4PO I1PI I2PI ',...
           'I3PI I4PI E2PI E3PI E4PI OD ODs CDBO CDBO5 CE EC CT SST TUR ',...
           'NO3 NH4 NO PO PI PT pH alk CA'];
        
%% Numero de puntos de control
% Calcular numero de puntos de control
fprintf(ID_File,'[NÚMERO DE PUNTOS DE CONTROL]\n');
fprintf(ID_File,'%d\n',UserData.N_CP);
fprintf(ID_File,'\n');

%% Listado de varibles para puntos de control
fprintf(ID_File,'[LISTADO DE VARIABLES PARA PUNTOS DE CONTROL]\n');
fprintf(ID_File,[NameVar,'\n']);
FormatText = ['%d',repmat(' %d',1,length(UserData.Var_ControlPoints)-1),'\n'];
fprintf(ID_File,FormatText,cell2mat(UserData.Var_ControlPoints));
fprintf(ID_File,'\n');

%% Listado de puntos de control
fprintf(ID_File,'[LISTADO DE PUNTOS DE CONTROL]\n');
fprintf(ID_File,'X Y Nombre Estadístico\n');
Data = UserData.ControlPoints;
if ~isempty(Data)
    for i = 1:UserData.N_CP   
        Tmp = [num2str(Data{i,1}),' ',num2str(Data{i,2}),' ',Data{i,3},' ',Data{i,4},'\n'];
        fprintf(ID_File,Tmp);
    end
end
fprintf(ID_File,'\n');

%% Numero de tramos de control
% Calcular numero de puntos de control
fprintf(ID_File,'[NÚMERO DE TRAMOS DE CONTROL]\n');
fprintf(ID_File,'%d\n',UserData.N_CB);
fprintf(ID_File,'\n');

%% Numero de tramos de control
fprintf(ID_File,'[LISTADO DE VARIABLES PARA TRAMOS DE CONTROL]\n');
fprintf(ID_File,[NameVar,'\n']);
FormatText = ['%d',repmat(' %d',1,length(UserData.Var_ControlBranch)-1),'\n'];
fprintf(ID_File,FormatText,cell2mat(UserData.Var_ControlBranch));
fprintf(ID_File,'\n');

%% Listado de tramos de control
fprintf(ID_File,'[LISTADO DE TRAMOS DE CONTROL]\n');
fprintf(ID_File,'X1 Y1 X2 Y2 Nombre\n');
Data = UserData.ControlBranch;
if ~isempty(Data)
    for i = 1:UserData.N_CB
        Tmp = [num2str(Data{i,1}),' ',num2str(Data{i,2}),' ',num2str(Data{i,3}),...
                ' ',num2str(Data{i,4}),' ',Data{i,5},'\n'];
        fprintf(ID_File,Tmp);
    end
end
fprintf(ID_File,'\n');

%% Listado de varibles para mapas
fprintf(ID_File,'[LISTADO DE VARIABLES PARA MAPAS]\n');
fprintf(ID_File,[NameVar,'\n']);
FormatText = ['%d',repmat(' %d',1,length(UserData.Var_Map)-1),'\n'];
fprintf(ID_File,FormatText,cell2mat(UserData.Var_Map));
fprintf(ID_File,'\n');

%% Etiquetas de variables
fprintf(ID_File,'[ETIQUETAS DE VARIABLES]\n');
fprintf(ID_File,[NameVar,'\n']);
fprintf(ID_File,[NameVar,'\n']);
fprintf(ID_File,'\n');

%% ETiquetas de variables
fprintf(ID_File,'[UNIDADES DE VARIABLES]\n');
fprintf(ID_File,[NameVar,'\n']);
fprintf(ID_File,UserData.Var_Unit{1});
for i = 2:length(UserData.Var_Unit)
    fprintf(ID_File,' %s',UserData.Var_Unit{i});
end
fprintf(ID_File,'\n\n');

%% Factores de conversión
fprintf(ID_File,'[FACTORES DE CONVERSION DE UNIDADES]\n');
fprintf(ID_File,[NameVar,'\n']);
FormatText = ['%f',repmat(' %f',1,length(UserData.ConversionFactors)-1),'\n'];
fprintf(ID_File,FormatText,UserData.ConversionFactors);
fprintf(ID_File,'\n');

%% Listado de varibles para mapas solo en cauce
fprintf(ID_File,'[LISTADO DE VARIABLES PARA MAPAS SOLO EN CAUCE]\n');
fprintf(ID_File,[NameVar,'\n']);
FormatText = ['%d',repmat(' %d',1,length(UserData.Var_MapVarStream)-1),'\n'];
fprintf(ID_File,FormatText,cell2mat(UserData.Var_MapVarStream));
fprintf(ID_File,'\n');

%% Listado de varibles para mapas solo en cauce para enmascarar
fprintf(ID_File,'[LISTADO DE VARIABLES PARA ENMASCARAR MAPAS EN CAUCE]\n');
fprintf(ID_File,[NameVar,'\n']);
FormatText = ['%d',repmat(' %d',1,length(UserData.Var_MapVarStreamMask)-1)];
fprintf(ID_File,FormatText,cell2mat(UserData.Var_MapVarStreamMask));

%% Cerrar Archivo
fclose(ID_File);