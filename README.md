# SIGA-CAL-Tools
SIGA-CAL Tools: Interfaz Gráfica de Simulación Geocientífica Abierta

**SIGA-CAL Tools** permite la configuración y ejecución de **SIGA-CAL** de manera fácil e intuitiva. A nivel informático esta herramienta ha sido desarrollada en el App Designer de Matlab R2019b, por lo que es necesario contar con el Runtime de Matlab (librerías compiladas de Matlab) para la versión R2019b. Para facilidad del usuario, el instalador de SIGA-CAL Tools cuenta con un asistente para guiar el proceso paso a paso.

# SIGA-CAL
El modelo SIGA-CAL v1.0 es una extensión de la herramienta de Simulación Geocientífica Abierta (SIGA) (TNC-Gotta, 2021) y de Calidad del Agua (CAL) (TNC-Gotta, 2022), que permite realizar simulaciones hidrosedimentológicas y de calidad del agua distribuidas a escala de cuenca con paso de tiempo diario. SIGA es un extensión del modelo SHIA, originalmente propuesto por Vélez (2001), y del modelo SHIA-SED, originalmente propuesto por Velázquez (2011). SIGA-CAL v1.0 se desarrolló con el propósito de:

- Robustecer la representación del proceso físico de tránsito de escorrentía en los cauces, con base en una caracterización morfométrica previa de la red de drenaje.
- Cuantificar el impacto de la variación temporal en la actividad y el desarrollo vegetal sobre la producción y transporte de escorrentía líquida y sedimentos.
- Incluir el ingreso de precipitación horizontal en los sectores de la cuenca donde este proceso se desarrolla, como un forzamiento hidrológico adicional al de la precipitación vertical.
- Considerar los procesos hidrológicos que ocurren específicamente en zonas de páramo.
- Incorporar el modelo geotécnico desarrollado por Aristizábal (2016) con base en el trabajo de D’Odorico (2003), para mejorar la cuantificación del aporte sedimentológico.

La extensión realizada en SIGA-CAL v1.0 consiste en la adición de la infraestructura necesaria para realizar modelación distribuida de calidad del agua, permitiendo representar el flujo de determinantes de interés ambiental de origen tanto puntual como difuso mediante un modelo ADZ en cauces acoplado con modelos de cargas difusas en ladera. Los cinco grandes módulos que conforman la herramienta SIGA-CAL v1.0 son:

- **Módulo meteorológico**, a través del cual es posible representar la variabilidad espacial y temporal de forzamientos como la temperatura, precipitación y precipitación horizontal en regiones donde pueden presentarse proceso de interceptación de niebla, radiación, entre otras, necesaria para la representación de procesos hidrológicos y fenológicos.
- **Módulo de transformación temporal de coberturas vegetales** que permite representar cambios en la vegetación inherentes al tipo de cobertura vegetal, y a través del cual es posible representar trayectorias de sucesión de coberturas vegetales como respuesta a la intervención del territorio mediante soluciones basadas en naturaleza (SBN).
- **Módulo de simulación hidrológica**, a través del cual es posible representar diferentes componentes del ciclo hidrológico como flujo superficial, flujo subsuperficial y flujo subterráneo.
- **Módulo de simulación sedimentológica**, a través del cual es posible representar flujos de sedimentos en suspensión. Módulo de simulación de calidad de agua, que constituye la extensión principal realizada en el marco del desarrollo de SIGA-CAL v1.0. Es importante señalar que, si bien las variables pH y alcalinidad aparecen en los archivos de configuración del modelo, estas variables aún no se simulan y se encuentran en estos archivos para facilitar desarrollos futuros en dirección a la adición de estas variables dentro de la modelación.

La herramienta **SIGA-CAL Tools**, es una interfaz de usuario desarrollada en el App Designer de Matlab R2019b, la cual permite la configuración y ejecución de **SIGA-CAL** de manera fácil e intuitiva. Entre las funcionalidades que brinda SIGACAL Tools se encuentran: la exploración gráfica de resultados, la comparación de escenarios, la edición de archivo, la configuración de escenarios, entre muchas otras. A continuación, se presentan un preview de algunas de las funcionalidades que brinda esta herramienta.
