function Write_CalibrationFile(FilePath, UserData)
% Funci�n para escritura de archivo de calibraci�n - SIGA-CAL 2022
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
% Esta funci�n escribe los par�metros en el archivo de calibraci�n, 
% siguiendo la estructura definida en la versi�n SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
%   FilePath    [String]: Ruta del archivo txt de calibraci�n SIGA-CAL
%   UserData    [Struct]: Estructura con los par�metros de calibraci�n
%     .Met              : Par�metros Meteorol�gicos
%     .Veg              : Par�metros de Restauraci�n
%     .Fen              : Par�metros Fenol�gicos
%     .Hid              : Par�metros Hidrol�gicos
%     .Sed              : Par�metros Sedimentol�gicos
%     .Geo              : Par�metros Geot�cnicos
%     .LoD              : Par�metros de aplicaci�n de Cargas Difusas
%     .Tsa              : Par�metros de Temperatura del Suelo y Agua
%     .EsC              : Par�metros de Escherichia Coli
%     .Nit              : Par�metros de Nitr�geno
%     .Fos              : Par�metros de F�sforo
%     .DBO              : Par�metros de DBO-Carbonacea
%     .Air              : Par�metros de Reaireaci�n
%     .CoT              : Par�metros de Coliformes Totales
%     .Tur              : Par�metros de Turbiedad
%     .CoE              : Par�metros de Conductividad El�ctrica
%     .SST              : Par�metros de Solidos Suspendidos Totales
%     .ADZ              : Par�metros de ADZ-QUASAR
%     .The              : Par�metros de Theta para correci�n de temperatura
%     .Tau              : Par�metros de rezagos temporales
%     .ICA              : Par�metros de ICA-EPM
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
%   Archivo de calibraci�n en formato txt
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File = fopen(FilePath,'w');

%% Guardar numero de filas de los factores matriciales
fprintf(ID_File,'[NMEROS DE FILAS DE LOS FACTORES MATRICIALES]\n');
fprintf(ID_File,'n_rest n_fenol n_carga\n');
fprintf(ID_File,'%.15g %.15g %.15g\n',[UserData.n_rest UserData.n_feno UserData.n_load]);
fprintf(ID_File,'\n');

%% Guardar Factores del modelo meteorol�gico
fprintf(ID_File,'[FACTORES DEL MODELO METEOROL�GICO]\n');
fprintf(ID_File,'minTAmin maxTAmin minTAmax maxTAmax minHR maxHR minRS ');
fprintf(ID_File,'maxRS minPV maxPV minUx maxUx minUy maxUy p Ez1 Ez2\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Met)-1),'\n'];
fprintf(ID_File,n,UserData.Met);
fprintf(ID_File,'\n');

%% Guardar Factores del modelo de restauraci�n de la vegetaci�n
fprintf(ID_File,'[FACTORES DEL MODELO DE RESTAURACI�N DE LA VEGETACI�N]\n');
fprintf(ID_File,'transicion CLC deltatm idQ accion\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Veg(1,:))-1),'\n'];
fprintf(ID_File,n,UserData.Veg');
fprintf(ID_File,'\n');

%% Guardar Factores del modelo fenol�gico
fprintf(ID_File,'[FACTORES DEL MODELO FENOL�GICO]\n');
fprintf(ID_File,'CLC psi theta n2 C_usle LAImax LAImin PHU l1 l2 l3 ');
fprintf(ID_File,'frPHUsen SMIc nSMI TAinf TAsup SOS1 SOS2 KCmin KCmax eta\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Fen(1,:))-1),'\n'];
fprintf(ID_File,n,UserData.Fen');
fprintf(ID_File,'\n');

%% Guardar Factores del modelo hidrol�gico
fprintf(ID_File,'[FACTORES DEL MODELO HIDROL�GICO]\n');
fprintf(ID_File,'fc_PV fc_PH fc_SU0 fc_SU1 fc_SU3 fc_ks fc_kp fc_ki fc_U2 ');
fprintf(ID_File,'fc_U3 fc_U4 fc_U5 us ui\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Hid)-1),'\n'];
fprintf(ID_File,n,UserData.Hid);
fprintf(ID_File,'\n');

%% Guardar Factores del modelo sedimentol�gico
fprintf(ID_File,'[FACTORES DEL MODELO SEDIMENTOL�GICO]\n');
fprintf(ID_File,'fc_E2Smax fc_E5Smax Bx b Us_arc Us_lim Us_are Ds_arc Ds_lim ');
fprintf(ID_File,'Ds_are Gs Rs\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Sed)-1),'\n'];
fprintf(ID_File,n,UserData.Sed);
fprintf(ID_File,'\n');

%% Guardar Factores del modelo geot�cnico
fprintf(ID_File,'[FACTORES DEL MODELO GEOT�CNICO]\n');
fprintf(ID_File,'fc_c fc_phi fc_rhoB fc_Zs alfa_crit alfa_stop a_stop\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Geo)-1),'\n'];
fprintf(ID_File,n,UserData.Geo);
fprintf(ID_File,'\n');

%% Guardar Factores de aplicaci�n de cargas difusas
fprintf(ID_File,'[FACTORES DE APLICACI�N DE CARGAS DIFUSAS]\n');
fprintf(ID_File,'idQ QEC QNO3 QNH4 QNO QPO QPI\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.CaD)-1),'\n'];
fprintf(ID_File,n,UserData.CaD');
fprintf(ID_File,'\n');

%% Guardar numero de rezados temporales a almacenar
fprintf(ID_File,'[NUMERO DE REZAGOS TEMPORALES A ALMACENAR]\n');
fprintf(ID_File,'ntau\n');
fprintf(ID_File,'%.15g\n',UserData.Tau);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de DBO carbonacea
fprintf(ID_File,'[FACTORES DEL MODELO DE DBO CARBONACEA]\n');
fprintf(ID_File,'ts_d Us_cdbo\n');
fprintf(ID_File,'%.15g %.15g\n',UserData.DBO);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de reaireaci�n
fprintf(ID_File,'[FACTORES DEL MODELO DE REAIREACION]\n');
fprintf(ID_File,'mod_rair fc_ts_ra\n');
fprintf(ID_File,'%.15g %.15g\n',UserData.Air);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de escherichia coli
fprintf(ID_File,'[FACTORES DEL MODELO DE ESCHERICHIA COLI]\n');
fprintf(ID_File,'ts_regen mrt_min Us_sst fr_bs fc_QEC\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.EsC)-1),'\n'];
fprintf(ID_File,n,UserData.EsC);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de nitr�geno
fprintf(ID_File,'[FACTORES DEL MODELO DE NITROGENO]\n');
fprintf(ID_File,['ts_desni ts_fija ts_pltNO3 ts_nitri ts_miner ',...
    'ts_inmov ts_pltNH4 ts_hidNO Us_NO K_odn fc_QNO fc_QNO3 fc_QNH4\n']);
n = ['%.15g',repmat(' %.15g',1,length(UserData.Nit)-1),'\n'];
fprintf(ID_File,n,UserData.Nit);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de f�sforo
fprintf(ID_File,'[FACTORES DEL MODELO DE FOSFORO]\n');
fprintf(ID_File,['ts_minerP ts_inmovP ts_pltPO ts_pltPI ts_fbPOin ',...
    'ts_fbPOout ts_fbPIin ts_fbPIout ts_hidPO Us_PO Us_PI fc_QPO fc_QPI\n']);
n = ['%.15g',repmat(' %.15g',1,length(UserData.Fos)-1),'\n'];
fprintf(ID_File,n,UserData.Fos);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de coliformes totales
fprintf(ID_File,'[FACTORES DEL MODELO DE COLIFORMES TOTALES]\n');
fprintf(ID_File,'K_ct exp_ct\n');
fprintf(ID_File,'%.15g %.15g\n',UserData.CoT);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de turbiedad
fprintf(ID_File,'[FACTORES DEL MODELO DE TURBIEDAD]\n');
fprintf(ID_File,'K_turb exp_turb\n');
fprintf(ID_File,'%.15g %.15g\n',UserData.Tur);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de conductividad el�ctrica
fprintf(ID_File,'[FACTORES DEL MODELO DE CONDUCTIVIDAD ELECTRICA]\n');
fprintf(ID_File,'b_CE alfa\n');
fprintf(ID_File,'%.15g %.15g\n',UserData.CoE);
fprintf(ID_File,'\n');

%% Guardar factores del modelo de solidos suspendidos totales
fprintf(ID_File,'[FACTORES PARA EL MODELO DE SOLIDOS SUSPENDIDOS TOTALES]\n');
fprintf(ID_File,'fr_arc fr_lim fr_are\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.SST)-1),'\n'];
fprintf(ID_File,n,UserData.SST);
fprintf(ID_File,'\n');

%% Guardar factores tetha para correci�n de tasas por temperatura
fprintf(ID_File,'[FACTORES THETA PARA LA CORRECCION DE TASAS POR TEMPERATURA]\n');
fprintf(ID_File,'th_cdbo th_bact th_N th_hidN th_rair th_hidP th_P\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.The)-1),'\n'];
fprintf(ID_File,n,UserData.The);
fprintf(ID_File,'\n');

%% Guardar factores para temperatura del suelo y del agua
fprintf(ID_File,'[FACTORES PARA TEMPERATURA DEL SUELO Y DEL AGUA]\n');
fprintf(ID_File,'t_ss t_sa t_ww t_wa\n');
n = ['%.15g',repmat(' %.15g',1,length(UserData.Tsa)-1),'\n'];
fprintf(ID_File,n,UserData.Tsa);
fprintf(ID_File,'\n');

%% Guardar factores para temperatura del suelo y del agua
fprintf(ID_File,'[FACTORES DEL MODELO ADZ-QUASAR]\n');
fprintf(ID_File,'fc_tm fc_tau\n');
fprintf(ID_File,'%.15g %.15g\n',UserData.ADZ);
fprintf(ID_File,'\n');

%% Guardar par�metro ICA-EPM.
fprintf(ID_File,'[ESTADO DE LA CUENCA PARA LA EVALUACION DEL ICA-EPM]\n');
fprintf(ID_File,'estado\n');
fprintf(ID_File,'%.15g\n',UserData.ICA);
fprintf(ID_File,'\n');

%% Guardar factores de pH
fprintf(ID_File,'[FACTORES PARA MODELO DE pH]\n');
fprintf(ID_File,'pCO2 roc fc_alk\n');
fprintf(ID_File,'%.15g %.15g %.15g\n',UserData.pH);

%% Cerrar Archivo
fclose(ID_File);