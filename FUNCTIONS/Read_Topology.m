function UserData = Read_Topology(FilePath)
% Función para lectura de archivo topología - SIGA-CAL 2022
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
% Esta función lee los parámetros contenidos en el archivo de topología, 
% siguiendo la estructura definida en la versión SIGA-CAL
%
%--------------------------------------------------------------------------
%                               INPUT DATA 
%--------------------------------------------------------------------------
% FilePath      [String]: Ruta del archivo txt de topología SIGA-CAL
%
% -------------------------------------------------------------------------
%                               OUTPUT DATA
% -------------------------------------------------------------------------
% UserData      [Struct]: Estructura con los parámetros de SIGA-CAL
%     .NumPixel         : Cantidad de celdas de la cuenca (Dominio computacional)
%     .AreaPixel        : Área de cada celda
%     .TypeTopo         : Tipo de topología
%     .X                : Coordenadas Este
%     .Y                : Coordendas Norte
%     .Z                : Elecavión
%     .Lat              : Latitud
%     .Lon              : Longitud
%     .Stream           : Pixeles que son red
%
% -------------------------------------------------------------------------

%% Start Function
% Abrir Archivo
ID_File  = fopen(FilePath,'r');

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
            if (i < 4)                
                % Lectura de dato 
                LineText    = fgetl(ID_File);
            end
            % Contador
            i = i + 1;
        end
        
        % TimeSeries Number
        if i == 1    
            % Cantidad de celdas de la cuenca (Dominio computacional)
            UserData.NumPixel    = str2double(LineText);
        elseif i == 2
            % Área de cada celda
            UserData.AreaPixel   = str2double(LineText);
        elseif i == 3 
            % Tipo de topología
            UserData.TypeTopo    = LineText;
        elseif i == 4
            Data            = textscan(ID_File,['%f',repmat(' %f',1,99)]);
            Data            = cell2mat(Data);
            Data(Data == -9999) = NaN;
            % Coordenadas Este
            UserData.X      = Data(:,6);
            % Coordendas Norte
            UserData.Y      = Data(:,7);
            % Elecavión
            UserData.Z      = Data(:,8);
            % Latitud
            UserData.Lat    = Data(:,9);
            % Longitud
            UserData.Lon    = Data(:,10);
            % ID Stream
            UserData.Dams   = logical(Data(:,5));
            % ID Stream
            UserData.Stream = logical(~isnan(Data(:,3)).*(~UserData.Dams));
              
            % Close File 
            fclose(ID_File);    
            break
        end

    end

    % Estructurar como matrix
    X = sort(unique(UserData.X),'ascend')';
    Y = sort(unique(UserData.Y),'descend');
    x = UserData.X;
    y = UserData.Y;
    % check input
    np = numel(x);
    if np ~= numel(y)
        error('TopoToolbox:wronginput',...
        'x and y must have the same number of elements.');
    end
    
    % force column vectors
    x   = x(:);
    y   = y(:);
    dx  = X(2)-X(1);
    dy  = Y(2)-Y(1);
    IX1 = (x-X(1))./dx + 1;
    IX2 = (y-Y(1))./dy + 1;
    IX1 = round(IX1);
    IX2 = round(IX2);
    I = IX1>length(X) | IX1<1 | IX2>length(Y) | IX2<1;
    if any(I(:))
        warning('TopoToolbox:outsidegrid',...
        'There are some points outside the grid''s borders');
    end
    I = ~I;
    if any(I)
        IX = nan(np,1);
        IX(I) = sub2ind([length(Y) length(X)],IX2(I),IX1(I));
    else
        IX  = nan(np,1);
    end

    % Posición de los datos
    UserData.IX = IX;

    % Recuadro de raster
    UserData.XX = X;
    UserData.YY = Y;
    
catch ME
    % Cerrar Archivo
    fclose(ID_File);
    
    % Mesaje de error
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
                            ME.stack(1).name, ME.stack(1).line, ME.message);
    errordlg( errorMessage )
    return
end