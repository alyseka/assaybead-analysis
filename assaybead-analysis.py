# assaybead-analysis
# This script can be used to determine the fluorescence intensity of 4.5, 2.8, and 1 µm diameter assay beads
# This code was used to generate the data in Krausz, et al. submitted to Biosensors and Bioelectronics in May 2021

from skimage import io, filters
import numpy as np

# Name the files
# Change according to your file naming convention
# B_files are the pseudo-flatfield corrected brightfield images (generated using pseudoflatfieldcorrection.ijm)
B_files = ["20210203_GFAP_Analysis/20210203_" + str(x) for x in ["0trial1", "0trial2", "0trial3", 100, 500, "10k"]]
B_files = [f + "_" + str(x) + "_flatfieldcorrected.tif" for x in [1, 2, 3] for f in B_files]

# F_files are the fluorescent images (generated using backgroundcorrection.ijm)
F_files = ["20210203_GFAP_Analysis/20210203_" + str(x) for x in ["0trial1", "0trial2", "0trial3", 100, 500, "10k"]]
F_files = [f + "_" + str(x) + "_ND4_100msexp_nobackgroundoutliers.tif" for x in [1, 2, 3] for f in F_files]

for i in range(0, len(B_files)):
	# Import the bead and fluorescent images
	B = io.imread(B_files[i])
	F = io.imread(F_files[i])

	# Threshold and binarize the bead image
	B_prime = B < filters.threshold_otsu(B) 
    # Otsu thresholding was used for the 4.5 and 2.8 µm diameter beads
    # Isodata thresholding was used for the 1 µm diameter beads
    # Choose a thresholding method that accurately identifies your particular bead size
	B_prime = np.divide(B_prime, np.max(B_prime))

	# Elementwise multiply binary bead image with fluorescent image
	F_prime = np.multiply(B_prime, F)

	# Sum the images
	b = np.sum(B_prime)
	f = np.sum(F_prime)

	# Print the results
	print("Filename: " + str(B_files[i]))
	print("b = " + str(b))
	print("f = " + str(f))
	print("f/b = " + str(f/b))
    # f/b (RFU/Bead Area) was used as the fluorescence intensity of the beads for standard assay curves

