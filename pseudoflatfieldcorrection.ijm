// Pick the folder that contains the brightfield images
path = getDirectory("Choose Location of Files");
path2 = getDirectory("Choose Save Location");

// Tell ImageJ the names of the files in the folder
list = getFileList(path);

// Process each of the images
for (i=0;i<list.length;i++)
{
	// Define the file name based on path and List
	fn = path+list[i];
	// Open the File
	open(fn);
	// Record the file name without the extension
	name = getTitle();
	name_noext = replace(name, ".tif", "");
	// Record the image ID
	original = getImageID();
	// Set Brightness/Contrast
	call("ij.ImagePlus.setDefault16bitRange", 14);
	// Duplicate the original image twice
	run("Duplicate...", " ");
	background = getImageID();
	background_title = getTitle();
	selectImage(original);
	run("Duplicate...", " ");
	analysis_image = getImageID();
	analysis_image_title = getTitle();
	// Blur the background image to obtain the pseudo-flat field image
	selectImage(background);
	run("Gaussian Blur...", "sigma=35"); // The optimal sigma for your images may be different. 
	// Choose a value of sigma that blurs the image so that no features are visible.
	// Measure the average intensity of the blurred image
	run("Select All");
	run("Measure");
	mean = getResult("Mean");
	// Calculate the pseudo-flat field corrected image
	run("Calculator Plus", "i1="+analysis_image_title+" i2="+background_title+" operation=[Divide: i2 = (i1/i2) x k1 + k2] k1="+mean+" k2=0 create");
	// Equation obtained from Basic Image Processing with FIJI/ImageJ by Kristopher Kubow, Ph.D.
	// Save the corrected image
	saved = getImageID();
	saveAs("Tiff", path2 + name_noext + "_flatfieldcorrected.tif");
	// Close all image windows
	close("*");
}