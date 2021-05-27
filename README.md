# assaybead-analysis

# About

_psuedoflatfieldcorrection.ijm (optional)_

Use this ImageJ Macro to pseudo-flatfield correct brightfield images only if the microscope used to obtain the images does not uniformly illuminate the field of view.

_backgroundcorrection.ijm_

Use this ImageJ Macro to background correct fluorescence images so that the pixel values between different images can be directly compared.

_assaybead-analysis.py_

Use this Python script to analyze the fluorescent intensity of assay beads that are homogeneous in size (Dynabeads). The script uses the thresholded brightfield image to define regions of interest on the fluorescent image to ensure that only the fluorescent intensity of the beads is analyzed.

# Suggested Use

Run _pseudoflatfieldcorrection.ijm_ (if necessary) followed by _backgroundcorrection.ijm_.

Use _assaybead-analysis.py_ to analyze the images produced by _pseudoflatfieldcorrection.ijm_ (if necessary) and _backgroundcorrection.ijm_. The output of _assaybead-analysis.py_ (RFU/bead area) can be used to construct a standard curve for a protein biomarker of interest (RFU/bead area vs. protein concentration).
