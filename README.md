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

### .NET Environment and scApp.exe
 - No additional installation (.NET Runtime 6.0 packaged directly into application)
 - The scApp.exe application is included in supplementary files in our publication located here: `IN SUBMISSION`

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

# Running Demo Dataset
1. Download the demo files (Total_5272_cells.dmt and 165_proteoforms.fastp) from MassIVE dataset [MSV000096472](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?task=1414496353314110b391a9356119ad5d)
1. Open the scApp.exe application and select the 2 input demo files
1. Click the `Run` button to process the demo dataset (should take approximately 5 minutes on a standard desktop)
1. Click the `Export` button to save the processed data as an XLSX file
1. Use Excel to convert the "scores" sheet in the XLSX file to a CSV file
1. Open the GSVA_clusters_PCA/ss_GSVA.qmd R Markdown file using RStudio
1. Load the processed data and run the script
1. The resulting figures will be saved in the same directory as the R Markdown file

# Running other datasets
You can use the scApp.exe application to process other datasets by following the same steps as the demo dataset. The inputs are a .dmt file (containing single cell ion data) and a .fastp (containing the proteoform data).