% Control de la micro-red para las 24 horas
clear; clc;

% Capacidad de la batería y estado inicial
cap_bat = 100; 
soc = 50;     

% Datos de generación (solar + eólica) y demanda del pueblo
gen_total = [0, 0, 0, 0, 2, 8, 15, 25, 35, 40, 45, 50, ...
    48, 42, 32, 20, 10, 3, 0, 0, 0, 0, 0, 0];

dem_total = [12, 10, 10, 10, 12, 18, 25, 30, 32, 30, 28, 26, ...
    25, 26, 28, 30, 35, 32, 25, 20, 18, 15, 14, 12];

disp('--- SIMULACION DEL SISTEMA DE ENERGIA ---'); %[output:454c22c7]
disp(' '); %[output:51a3247a]

% Recorremos cada hora del día
for h = 1:24 %[output:group:724a89f0]

    g = gen_total(h);
    d = dem_total(h);

    % Prendemos todo por defecto
    escuela = "ACTIVA";
    bombeo = "ACTIVO";
    alumbrado = "ACTIVO";

    % Vemos si hay superávit o déficit
    if g >= d
        % Sobra energía, cargamos la batería
        excedente = g - d;
        soc = soc + (excedente / cap_bat) * 100;

        % Que no pase del 100%
        if soc > 100
            soc = 100;
        end

        estado_caso = "SUPERÁVIT";
    else
        % Falta energía, gastamos batería
        faltante = d - g;
        soc = soc - (faltante / cap_bat) * 100;

        % Que no baje de 0% (evitar vaciamiento profundo)
        if soc < 0
            soc = 0;
        end

        estado_caso = "DÉFICIT";

        % Revisamos los rangos de la batería para apagar cosas
        if soc > 40
            ruta = "Segura";
        elseif soc > 20 && soc <= 40
            ruta = "Alerta";
            alumbrado = "APAGADO"; % Apagamos luces públicas
        else
            ruta = "Emergencia";
            alumbrado = "APAGADO";
            bombeo = "APAGADO";    % Apagamos bombeo y dejamos solo la escuela
        end
    end

    % Imprimimos el reporte en la consola
    fprintf('Hora %02d:00 | Gen: %4.1f kWh | Dem: %4.1f kWh | %s\n', h, g, d, estado_caso); %[output:39ef6b1c] %[output:5fe146b2] %[output:7654a27c] %[output:12c2892e] %[output:9b1753b5] %[output:351bce7f] %[output:0538a162] %[output:1c31008b] %[output:4dc27cf9] %[output:089c91c5] %[output:04895b86] %[output:00528462] %[output:5605659d] %[output:48853509] %[output:0feed452] %[output:7fef0971] %[output:4fe1fb86] %[output:79f90b5f] %[output:21e83ea6] %[output:1b622b49] %[output:524867e9] %[output:7818ea59] %[output:912eb813] %[output:8b529c62]
    fprintf('           -> SOC Batería: %5.1f%%\n', soc); %[output:18ae8604] %[output:66aee62e] %[output:8bd2cc41] %[output:4f18eb6c] %[output:1809263c] %[output:0eed9b2a] %[output:0598c1b7] %[output:39bac6bb] %[output:3cc44d3e] %[output:3ae1d610] %[output:644cb41e] %[output:40b6855a] %[output:7499e8e9] %[output:336c3fbe] %[output:413d8caa] %[output:3afd4828] %[output:7b96f740] %[output:9cc70053] %[output:7e071cea] %[output:90978cf9] %[output:7afcdf32] %[output:347e2c4b] %[output:94ec9463] %[output:2959df95]
    if estado_caso == "DÉFICIT"
        fprintf('           -> Zona de Control: Ruta %s\n', ruta); %[output:1ea4ccc1] %[output:445237b0] %[output:6445973b] %[output:044994dd] %[output:66a99389] %[output:1fab38b9] %[output:495b499c] %[output:6094f07d] %[output:94fae9b9] %[output:2ad0eabc] %[output:2beaa5dc] %[output:29dbaea3] %[output:7488eaf6] %[output:0013455f] %[output:1fad6041] %[output:02a7019d] %[output:4ffa5dfa]
    end
    fprintf('           -> Servicios: Escuela [%s] | Bombeo [%s] | Alumbrado [%s]\n', ... %[output:7c7512f1] %[output:90c8a51a] %[output:2ca01f22] %[output:0c225588] %[output:99b540ce] %[output:182d895f] %[output:3f4b6b8c] %[output:17a7a591] %[output:497e7675] %[output:598bfdf9] %[output:896eb137] %[output:763b05c1] %[output:87dbd996] %[output:030fbc5f] %[output:4d0811a4] %[output:677e91c8] %[output:0d106fed] %[output:23a5613e] %[output:83f82193] %[output:52470895] %[output:810e3793] %[output:44406e79] %[output:18425b87] %[output:9f6d26b1]
        escuela, bombeo, alumbrado); %[output:7c7512f1] %[output:90c8a51a] %[output:2ca01f22] %[output:0c225588] %[output:99b540ce] %[output:182d895f] %[output:3f4b6b8c] %[output:17a7a591] %[output:497e7675] %[output:598bfdf9] %[output:896eb137] %[output:763b05c1] %[output:87dbd996] %[output:030fbc5f] %[output:4d0811a4] %[output:677e91c8] %[output:0d106fed] %[output:23a5613e] %[output:83f82193] %[output:52470895] %[output:810e3793] %[output:44406e79] %[output:18425b87] %[output:9f6d26b1]
    fprintf('-------------------------------------------------------------\n'); %[output:57262137] %[output:64a1c1c8] %[output:8543951f] %[output:9b561b7a] %[output:015ac4a4] %[output:29d2acd3] %[output:17498c75] %[output:9cf64469] %[output:0231454c] %[output:726229ee] %[output:145e1f8b] %[output:5cfce92d] %[output:269519ee] %[output:1d9b8c16] %[output:639ed027] %[output:964c93cc] %[output:17865755] %[output:0931a1f2] %[output:8e4cd25c] %[output:9c8eb104] %[output:64f27f0e] %[output:9b3b29ba] %[output:9e08ba93] %[output:7e1eabd4]

end %[output:group:724a89f0]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":9.8}
%---
%[output:454c22c7]
%   data: {"dataType":"text","outputData":{"text":"--- SIMULACION DEL SISTEMA DE ENERGIA ---\n","truncated":false}}
%---
%[output:51a3247a]
%   data: {"dataType":"text","outputData":{"text":" \n","truncated":false}}
%---
%[output:39ef6b1c]
%   data: {"dataType":"text","outputData":{"text":"Hora 01:00 | Gen:  0.0 kWh | Dem: 12.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:18ae8604]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  38.0%\n","truncated":false}}
%---
%[output:1ea4ccc1]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Alerta\n","truncated":false}}
%---
%[output:7c7512f1]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:57262137]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:5fe146b2]
%   data: {"dataType":"text","outputData":{"text":"Hora 02:00 | Gen:  0.0 kWh | Dem: 10.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:66aee62e]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  28.0%\n","truncated":false}}
%---
%[output:445237b0]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Alerta\n","truncated":false}}
%---
%[output:90c8a51a]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:64a1c1c8]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:7654a27c]
%   data: {"dataType":"text","outputData":{"text":"Hora 03:00 | Gen:  0.0 kWh | Dem: 10.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:8bd2cc41]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  18.0%\n","truncated":false}}
%---
%[output:6445973b]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:2ca01f22]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:8543951f]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:12c2892e]
%   data: {"dataType":"text","outputData":{"text":"Hora 04:00 | Gen:  0.0 kWh | Dem: 10.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:4f18eb6c]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   8.0%\n","truncated":false}}
%---
%[output:044994dd]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:0c225588]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:9b561b7a]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:9b1753b5]
%   data: {"dataType":"text","outputData":{"text":"Hora 05:00 | Gen:  2.0 kWh | Dem: 12.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:1809263c]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:66a99389]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:99b540ce]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:015ac4a4]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:351bce7f]
%   data: {"dataType":"text","outputData":{"text":"Hora 06:00 | Gen:  8.0 kWh | Dem: 18.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:0eed9b2a]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:1fab38b9]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:182d895f]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:29d2acd3]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:0538a162]
%   data: {"dataType":"text","outputData":{"text":"Hora 07:00 | Gen: 15.0 kWh | Dem: 25.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:0598c1b7]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:495b499c]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:3f4b6b8c]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:17498c75]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:1c31008b]
%   data: {"dataType":"text","outputData":{"text":"Hora 08:00 | Gen: 25.0 kWh | Dem: 30.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:39bac6bb]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:6094f07d]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:17a7a591]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:9cf64469]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:4dc27cf9]
%   data: {"dataType":"text","outputData":{"text":"Hora 09:00 | Gen: 35.0 kWh | Dem: 32.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:3cc44d3e]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   3.0%\n","truncated":false}}
%---
%[output:497e7675]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:0231454c]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:089c91c5]
%   data: {"dataType":"text","outputData":{"text":"Hora 10:00 | Gen: 40.0 kWh | Dem: 30.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:3ae1d610]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  13.0%\n","truncated":false}}
%---
%[output:598bfdf9]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:726229ee]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:04895b86]
%   data: {"dataType":"text","outputData":{"text":"Hora 11:00 | Gen: 45.0 kWh | Dem: 28.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:644cb41e]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  30.0%\n","truncated":false}}
%---
%[output:896eb137]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:145e1f8b]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:00528462]
%   data: {"dataType":"text","outputData":{"text":"Hora 12:00 | Gen: 50.0 kWh | Dem: 26.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:40b6855a]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  54.0%\n","truncated":false}}
%---
%[output:763b05c1]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:5cfce92d]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:5605659d]
%   data: {"dataType":"text","outputData":{"text":"Hora 13:00 | Gen: 48.0 kWh | Dem: 25.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:7499e8e9]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  77.0%\n","truncated":false}}
%---
%[output:87dbd996]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:269519ee]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:48853509]
%   data: {"dataType":"text","outputData":{"text":"Hora 14:00 | Gen: 42.0 kWh | Dem: 26.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:336c3fbe]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  93.0%\n","truncated":false}}
%---
%[output:030fbc5f]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:1d9b8c16]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:0feed452]
%   data: {"dataType":"text","outputData":{"text":"Hora 15:00 | Gen: 32.0 kWh | Dem: 28.0 kWh | SUPERÁVIT\n","truncated":false}}
%---
%[output:413d8caa]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  97.0%\n","truncated":false}}
%---
%[output:4d0811a4]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:639ed027]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:7fef0971]
%   data: {"dataType":"text","outputData":{"text":"Hora 16:00 | Gen: 20.0 kWh | Dem: 30.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:3afd4828]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  87.0%\n","truncated":false}}
%---
%[output:94fae9b9]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Segura\n","truncated":false}}
%---
%[output:677e91c8]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:964c93cc]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:4fe1fb86]
%   data: {"dataType":"text","outputData":{"text":"Hora 17:00 | Gen: 10.0 kWh | Dem: 35.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:7b96f740]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  62.0%\n","truncated":false}}
%---
%[output:2ad0eabc]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Segura\n","truncated":false}}
%---
%[output:0d106fed]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [ACTIVO]\n","truncated":false}}
%---
%[output:17865755]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:79f90b5f]
%   data: {"dataType":"text","outputData":{"text":"Hora 18:00 | Gen:  3.0 kWh | Dem: 32.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:9cc70053]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:  33.0%\n","truncated":false}}
%---
%[output:2beaa5dc]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Alerta\n","truncated":false}}
%---
%[output:23a5613e]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [ACTIVO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:0931a1f2]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:21e83ea6]
%   data: {"dataType":"text","outputData":{"text":"Hora 19:00 | Gen:  0.0 kWh | Dem: 25.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:7e071cea]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   8.0%\n","truncated":false}}
%---
%[output:29dbaea3]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:83f82193]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:8e4cd25c]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:1b622b49]
%   data: {"dataType":"text","outputData":{"text":"Hora 20:00 | Gen:  0.0 kWh | Dem: 20.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:90978cf9]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:7488eaf6]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:52470895]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:9c8eb104]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:524867e9]
%   data: {"dataType":"text","outputData":{"text":"Hora 21:00 | Gen:  0.0 kWh | Dem: 18.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:7afcdf32]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:0013455f]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:810e3793]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:64f27f0e]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:7818ea59]
%   data: {"dataType":"text","outputData":{"text":"Hora 22:00 | Gen:  0.0 kWh | Dem: 15.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:347e2c4b]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:1fad6041]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:44406e79]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:9b3b29ba]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:912eb813]
%   data: {"dataType":"text","outputData":{"text":"Hora 23:00 | Gen:  0.0 kWh | Dem: 14.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:94ec9463]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:02a7019d]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:18425b87]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:9e08ba93]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
%[output:8b529c62]
%   data: {"dataType":"text","outputData":{"text":"Hora 24:00 | Gen:  0.0 kWh | Dem: 12.0 kWh | DÉFICIT\n","truncated":false}}
%---
%[output:2959df95]
%   data: {"dataType":"text","outputData":{"text":"           -> SOC Batería:   0.0%\n","truncated":false}}
%---
%[output:4ffa5dfa]
%   data: {"dataType":"text","outputData":{"text":"           -> Zona de Control: Ruta Emergencia\n","truncated":false}}
%---
%[output:9f6d26b1]
%   data: {"dataType":"text","outputData":{"text":"           -> Servicios: Escuela [ACTIVA] | Bombeo [APAGADO] | Alumbrado [APAGADO]\n","truncated":false}}
%---
%[output:7e1eabd4]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------------------------------\n","truncated":false}}
%---
