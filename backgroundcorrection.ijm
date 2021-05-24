// Pick the folder that contains the images
path = getDirectory("Choose Location of Files");
path2 = getDirectory("Choose Save Location");

// Tell ImageJ the names of the files in the folder
list = getFileList(path);

// Process each of the images
for (i=0;i<list.length;i++)
{
	// Define the file name based on path and list
	fn = path+list[i];
	// Open the file
	open(fn);
	// Record the file name without the extension
	name = getTitle();
	name_noext = replace(name, ".tif", "");
	// Set Brightness/Contrast
	setMinAndMax(0, 16383);
	call("ij.ImagePlus.setDefault16bitRange", 14);
	// Subtract the image background
	run("Subtract Background...", "rolling=50");
	// Remove any outlier pixels from the image
	// This step minimizes the impact of quantum dots not attached to beads
	run("Remove Outliers...", "radius=1 threshold=50 which=Bright");
	// Save the file with a new name
	saveAs("Tiff", path2 + name_noext + "_nobackgroundoutliers.tif");
	close();
}
