# SIGA-CAL-Tools  
SIGA-CAL Tools: Open Geoscientific Simulation Graphical Interface

**SIGA-CAL Tools** allows the configuration and execution of **SIGA-CAL** in an easy and intuitive way. From a computational perspective, this tool has been developed in Matlab R2019b's App Designer, so it is necessary to have the Matlab Runtime (compiled Matlab libraries) for version R2019b. For the user's convenience, the SIGA-CAL Tools installer includes a step-by-step wizard to guide the installation process.

# SIGA-CAL  
The SIGA-CAL v1.0 model is an extension of the Open Geoscientific Simulation tool (SIGA) (TNC-Gotta, 2021) and the Water Quality tool (CAL) (TNC-Gotta, 2022), which allows distributed hydrosedimentological and water quality simulations at a watershed scale with a daily time step. SIGA is an extension of the SHIA model, originally proposed by Vélez (2001), and the SHIA-SED model, originally proposed by Velázquez (2011). SIGA-CAL v1.0 was developed with the purpose of:

- Strengthening the representation of the physical process of runoff transit in channels, based on a prior morphometric characterization of the drainage network.
- Quantifying the impact of temporal variation in vegetation activity and development on the production and transport of liquid runoff and sediments.
- Including horizontal precipitation input in watershed areas where this process occurs, as an additional hydrological forcing to vertical precipitation.
- Considering the hydrological processes that specifically occur in páramo areas.
- Incorporating the geotechnical model developed by Aristizábal (2016), based on the work of D’Odorico (2003), to improve sediment load quantification.

The extension made in SIGA-CAL v1.0 consists of the addition of the necessary infrastructure to perform distributed water quality modeling, allowing the representation of point and diffuse environmental determinants' flow using an ADZ model in channels, coupled with diffuse load models on slopes. The five main modules that make up the SIGA-CAL v1.0 tool are:

- **Meteorological module**, which allows representing the spatial and temporal variability of forcings such as temperature, precipitation, and horizontal precipitation in regions where processes like fog interception, radiation, and others may occur, necessary for the representation of hydrological and phenological processes.
- **Vegetation cover transformation module**, which allows representing changes in vegetation inherent to the type of vegetation cover and through which it is possible to represent succession trajectories of vegetation covers in response to territorial intervention through nature-based solutions (NBS).
- **Hydrological simulation module**, which allows representing different components of the hydrological cycle such as surface flow, subsurface flow, and groundwater flow.
- **Sedimentological simulation module**, which allows representing suspended sediment flows. The water quality simulation module, which constitutes the main extension made as part of the development of SIGA-CAL v1.0. It is important to note that, although pH and alkalinity variables appear in the model configuration files, these variables are not yet simulated and are included in these files to facilitate future developments aimed at incorporating these variables into the model.

The **SIGA-CAL Tools** tool is a user interface developed in Matlab R2019b's App Designer, which allows the configuration and execution of **SIGA-CAL** in an easy and intuitive way. Some of the functionalities provided by SIGA-CAL Tools include graphical exploration of results, scenario comparison, file editing, scenario configuration, and many more. Below is a preview of some of the features this tool offers.
