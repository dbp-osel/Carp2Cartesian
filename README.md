# Carp2Cartesian

This software package provides tools to convert tetrahedral meshes from VTK to uniform Cartesian grids in JSON format. The output files can be imported into GPU-based applications such as the WebGL programs in [WGLPackedCartesian](https://github.com/dbp-osel/WGLPackedCartesian),  for accelerated computing.

## Requirements

This software has been tested on macOS 12.6.7 and Ubuntu Linux 22.04.3 LTS.

The programs depend on the following software packages:

* [meshtool](https://github.com/ElsevierSoftwareX/SOFTX_2019_291): for conversion of the meshes from VTK to CARP
* [MATLAB](https://www.mathworks.com/products/matlab.html): for conversion from CARP to Cartesian format. The programs were tested on MATLAB R2022b Update 1 (9.13.0.2080170)

## File Directory

The two main directories of the project are:

* **[Carp2CartesianApp](./Carp2CartesianApp):** Graphical version of the application that can be installed in MATLAB.
* **[Carp2CartesianScript](./Carp2CartesianScript):** Scripting version of the app that can be used for batch processing of a number of mesh files.

Each of the above mentioned directories has its own README file that explains the installation and usage of the programs.

## processMesh bash script

There is a bash script in the main directory of this repository that can convert VTK files to the appropriate format that can be opened in the MATLAB conversion tools.

The script relies on the [meshtool](https://github.com/ElsevierSoftwareX/SOFTX_2019_291) to be compiled on the system and the meshtool binary to be on the system path.

You should also add the location of the processMesh bash script to the path. For example, if the absolute path of the repository on the local drive is `/path/to/Carp2Cartesian-clone-repo`, you can type the following into the `bash` command prompt to add this to the search path:

```bash
export PATH=$PATH:/path/to/Carp2Cartesian-clone-repo
```

This script has its own help instructions that can be accessed by typing:
```bash
processMesh -h
```

### Example of using processMesh
Assuming that we want to convert a VTK mesh named `01-350um.vtk` to suitable CARP format with a base name `01-350um-carp`, we can type the following command on the bash prompt:

```bash
processMesh 01-350um.vtk -o 01-350um-carp -pv
```

where the `-p` option prepares all the necessary files for import in MATLAB and the `-v` option activates the verbose mode.

## License
Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

## Authors

**Developer:**   Abouzar Kaboudian

**Contact:**    [abouzar.kaboudian@fda.hhs.gov](mailto:abouzar.kaboudian@fda.hhs.gov)

## Disclaimers
*This software and documentation (the "Software") were developed at the Food and Drug Administration (FDA) by employees of the Federal Government in the course of their official duties. Pursuant to Title 17, Section 105 of the United States Code, this work is not subject to copyright protection and is in the public domain. Permission is hereby granted, free of charge, to any person obtaining a copy of the Software, to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, or sell copies of the Software or derivatives, and to permit persons to whom the Software is furnished to do so. FDA assumes no responsibility whatsoever for use by other parties of the Software, its source code, documentation or compiled executables, and makes no guarantees, expressed or implied, about its quality, reliability, or any other characteristic. Further, use of this code in no way implies endorsement by the FDA or confers any advantage in regulatory decisions. Although this software can be redistributed and/or modified freely, we ask that any derivative works bear some notice that they are derived from it, and any modified versions bear some notice that they have been modified.*

*The mention of commercial products, their sources, or their use in connection with material reported herein is not to be construed as either actual or implied endorsement or recommendation of such products by the US Government or the Department of Health and Human Services. HHS is not responsible for any "off-site" webpage referenced in this product.*
