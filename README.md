# IntermedMap Project V.01

##Project available: https://kycva9-h0furkan-kepenek.shinyapps.io/IntermedMap_Project/
By İrem Kahveci<sup>1</sup>, Hamdi Furkan Kepenek<sup>1</sup>, Alaattin Şen<sup>2</sup>


<sup>1</sup> Abdullah Gül University, Molecular Biology and Genetics, Kayseri – TURKEY
- Email: irem.kahveci@agu.edu.tr, hamdifurkan.kepenek@agu.edu.tr, sena@agu.edu.tr

## Abstract

Intermediates are key molecules in biological processes that serve as "mediators" facilitating reactions and regulating biochemical pathways. They are involved in energy production, biosynthesis, degradation, and act as signaling molecules, essential for maintaining cellular functions and supporting life processes. This project aims to observe the relationships between intermediates and pathways through a "Network" and create a comprehensive "Databank" covering information from IUPAC names to 3D structures. The project leverages the R Shiny package, an open-source tool increasingly used in data science, to create interactive web applications from R.

**Keywords:** R Shiny, Metabolite, Pathway, CollapsibleTree, visNetwork, igraph

## Introduction

In the fields of biochemistry and biological research, intermediates play a critical role in understanding cellular processes, metabolic pathways, and signaling cascades. Intermediates are molecules formed and transformed during biochemical reactions, serving as key players in various biological processes. Here are the key points highlighting the importance of intermediates and their pathways:

1. **Metabolic Pathways:** Intermediates are central to metabolic pathways, which are interconnected series of biochemical reactions within cells. Studying intermediates helps researchers understand how cells synthesize, break down, and utilize biomolecules.

2. **Enzyme Function and Regulation:** Intermediates provide valuable information about enzyme function and regulation, including mechanisms, substrate binding, catalytic activity, and enzyme regulation.

3. **Signaling Cascades:** Intermediates play a critical role in cellular communication and response to external stimuli, influencing processes like gene expression, cell proliferation, and differentiation.

4. **Disease Mechanisms:** Intermediates are often implicated in disease mechanisms, making their study relevant for understanding metabolic diseases, cancer, and neurodegenerative conditions.

5. **Drug Discovery:** Intermediates are crucial in drug discovery and development processes, aiding in the design and optimization of therapeutic agents.

## Materials and Methods

### Data Collection and Filtering Process

Intermediate data was sourced from PubChem and research articles. Data included IUPAC Name, General Information, Pathway name, Previous Intermediate, Next Intermediate, Cas Number, Chemical Formula (2D and 3D). Data was checked for reliability and transferred to R environment using readxl (V1.4.2).

![Transferred data after filtering in R Shiny]([link_to_image.png]((https://drive.google.com/file/d/1IEyKDp0NdpVHxpLX0PSGl8X9erba2fBS/view?usp=sharing)))

### Intermediate Pathway Mapping Process

Mapping was performed using R Studio and R (V4.3.0), with packages including visNetwork (V2.1.2), igraph (V1.4.3), DiagrammeR (V1.0.10), collapsibleTree (V0.1.7).

### Development of the Web Application

The web application was developed using Shiny (V1.7.4), shinythemes (V1.2.0), DT (V0.28), and MASS (V7.3-60) packages.

![Mapped data relationship in R Shiny]([link_to_image.png]((https://drive.google.com/file/d/19oB3IJkcgYQ6YhZaMYY5ieodAcGxxw-M/view?usp=sharing)))

![IntermedMap Project App Dashboard Tab]([link_to_image.png]((https://drive.google.com/file/d/1xTU-JK4rBS6ZKKKF8kc3WJ0jVBbK7Ndq/view?usp=sharing)))

## Conclusion

IntermedMap is a cutting-edge web-based software empowering researchers to visualize intermediates and pathway networks interactively. It provides user-friendly access to valuable information and insights into various biochemical processes. The project relies on reliable data sources, making it a safe resource for future research.

## References

[1] Nelson, D. L., Cox, M. M. (2017). Lehningher Principles of BioChemistry W.H. Freeman. 8th edition.

[2] Prabhu, A., Sarcar, B., Kahali, S., Yuan, Z., Johnson, J. J., Adam, K. P., Chinnaiyan, P. (2014). Cysteine catabolism: a novel metabolic pathway contributing to glioblastoma growth. Cancer research. 74(3), 787-796.

[3] Kerr, T. A., Matsumoto, Y., Matsumoto, H., Xie, Y., Hirschberger, L. L., Stipanuk, M. H., Davidson, N. O. (2014). Cysteine sulfinic acid decarboxylase regulation: A role for farnesoid X receptor and small heterodimer partner in murine hepatic taurine metabolism. Hepatology Research, 44(10), E218-E228.

[4] Wretlind, K. A. J. (1953). Replacement of valine in the diet by alpha-ketoisovaleric acid. Acta physiol. stand., 27, 183-188.

[5] Xu, Y., Jiang, H., Li, L., Chen, F., Liu, Y., Zhou, M., ... Liu, J. (2020). Branched-chain amino acid catabolism promotes thrombosis risk by enhancing tropomodulin-3 propionylation in platelets. Circulation, 142(1), 49-64.

[6] Liu, P., Torrens-Spence, M. P., Ding, H., Christensen, B. M., Li, J. (2013). Mechanism of cysteine-dependent inactivation of aspartate/glutamate/cysteine sulfinic acid alpha-decarboxylases. Amino acids, 44, 391-404.

[7] RStudio Team (2020). RStudio: Integrated Development for R. RStudio, PBC, Boston, MA. URL [RStudio](http://www.rstudio.com/).

[8] Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J, McPherson J, Dipert A, Borges B (2023). shiny: Web Application Framework for R. R package version 1.7.4.9002, [shiny](https://shiny.rstudio.com/).

[9] GitHub - dmurdoch/rgl: rgl is a 3D visualization system based on OpenGL. It provides a medium to high level interface for use in R, currently modelled on classic R graphics, with extensions to allow for interaction. [GitHub rgl](https://github.com/dmurdoch/rgl).

[10] Shiny Themes. [shinythemes](https://rstudio.github.io/shinythemes/).

[11] shinyWidgets: Extend widgets available in shiny. GitHub. [shinyWidgets](https://github.com/dreamRs/shinyWidgets).

[12] Shiny Dashboard. [shinydashboard](https://rstudio.github.io/shinydashboard/).

[13] Chang, W., Cheng, J., Allaire, J. J., Xie, Y., McPherson, J. (2020). shinythemes: Themes for Shiny. [shinythemes](https://CRAN.R-project.org/package=shinythemes).

[14] Sievert, C. (2019). collapsibleTree: Interactive Collapsible Tree Diagrams using ’D3.js’. [collapsibleTree](https://CRAN.R-project.org/package=collapsibleTree).

[15] Csárdi, G., Nepusz, T. (2006). The igraph software package for complex network research. InterJournal, Complex Systems, 1695(5), 1-9. [igraph](https://igraph.org).

[16] Allaire, J. J., Cheng, J., Xie, Y., McPherson, J., Chang, W., Allen, J., Hyndman, R. (2020). DiagrammeR: Graph and network visualization. [DiagrammeR](https://CRAN.R-project.org/package=DiagrammeR).

[17] Almende, B., Thieurmel, B., Viallefont, T. (2019). visNetwork: Network Visualization using ’vis.js’ Library. [visNetwork](https://CRAN.R-project.org/package=visNetwork).
