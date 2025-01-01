# scPiMS
Tools for the processing and analysis of single cell Proteoform imaging Mass Spectrometry (scPiMS)

### scApp.exe (.NET WPF application)
 - scores proteoforms against single cell ions

### scAnalyzer.m (MATLAB code)
 - optical single cell feature correlation
 - scPiMS single cell feature extraction for downstream I2MS processing

### GSVA_clusters_PCA/ss_GSVA.qmd (Quarto R Markdown)
 - pathway-adjusted PAScore based on single sample GSVA analysis
 - cluster analysis
 - Heatmap
 - PCA plots
 - tSNE plot
 - UMAP plot

# Installation Instructions

### System Requirements
Because the scApp.exe is a Windows Presentation Foundation (WPF) application that requires Windows 10 or later to run,
all validation and processing were performed on Windows 10 22H2.

### .NET Environment
 - No additional installation (.NET Runtime 6.0 packaged directly into application)

### MATLAB
 - MATLAB 2019b or later
 - Image Processing Toolbox
 - Statistics and Machine Learning Toolbox
 - Parallel Computing Toolbox
 - Installs in less than 10 minutes on standard workstation

 ### R Environment
 - R (v3.6.0+) and RStudio (2024.12.0+)
	- https://posit.co/download/rstudio-desktop/ 
 - Installs in less than 10 minutes on standard workstation

 ### scApp.exe
 - The scApp.exe application is included in supplementary files in our publication located here: `IN SUBMISSION`


scApp.exe ... select FDR threshold
output: XLSX (export button)
input to MATLAB and R: 1 csv files (from score matrix)

# Running Demo Dataset `FIX`
1. Download the demo dataset from the following link: 
1. Unzip the demo dataset to a location of your choice
1. Open the scApp.exe application
1. Click the `Load` button and navigate to the unzipped demo dataset folder
1. Click the `Run` button to process the demo dataset
1. The processed data will be saved in the same folder as the demo dataset
1. Open the scAnalyzer.m MATLAB script
1. Load the processed data and run the script
1. Open the GSVA_clusters_PCA/ss_GSVA.qmd R Markdown file
1. Load the processed data and run the script
1. The results will be saved in the same folder as the demo dataset
1. Review the results and enjoy!
1. For more information, please refer to the user manual