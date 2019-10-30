import java.nio.file.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.HashSet;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

//Path sourceDirectory = Paths.get("C:/Users/heror/Documents/Processing/directoryCopying/src");

//Path targetDirectory = Paths.get("C:/Users/heror/Documents/Processing/directoryCopying/dest");



void setup() {
  //Files.walkFileTree(sourceDirectory, new HashSet<>(), 2, new FileVisitor<Path>());
  //Source directory which you want to copy to new location
  String targetDirectory = directoryChooser();
  if (targetDirectory!=null) {
    File sourceFolder = new File(System.getProperty("user.dir")+"\\templates\\Tecbot2019Test");
    sourceFolder = new File("https://github.com/TrevCan/FRC_IntelliJ_Idea.git");

    //Target directory where files should be copied
    File destinationFolder = new File("c:\\tempNew");

    //Call Copy function
    try {
      File targetDir = new File(targetDirectory);
      copyFolder(sourceFolder, targetDir);
    } 
    catch(IOException e) {
      e.printStackTrace();
    }

    directoryChooser();
  } else{
    String message = "Invalid destination folder.";
    JOptionPane.showMessageDialog(null,message);
  }
}
void draw() {
}
private static void copyFolder(File sourceFolder, File destinationFolder) throws IOException
{
  //Check if sourceFolder is a directory or file
  //If sourceFolder is file; then copy the file directly to new location
  if (sourceFolder.isDirectory())
  {
    //Verify if destinationFolder is already present; If not then create it
    if (!destinationFolder.exists())
    {
      destinationFolder.mkdir();
      System.out.println("Directory created :: " + destinationFolder);
    }

    //Get all files from source directory
    String files[] = sourceFolder.list();

    //Iterate over all files and copy them to destinationFolder one by one
    for (String file : files)
    {
      File srcFile = new File(sourceFolder, file);
      File destFile = new File(destinationFolder, file);

      //Recursive function call
      copyFolder(srcFile, destFile);
    }
  } else
  {
    //Copy the file content from one place to another
    Files.copy(sourceFolder.toPath(), destinationFolder.toPath(), StandardCopyOption.REPLACE_EXISTING);
    System.out.println("File copied :: " + destinationFolder);
  }
}


String directoryChooser() {
  String selectedFile = "";
  JFileChooser chooser = new JFileChooser();
  chooser.setCurrentDirectory(new java.io.File("."));
  chooser.setDialogTitle("choosertitle");
  chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
  chooser.setAcceptAllFileFilterUsed(false);

  if (chooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
    selectedFile = String.valueOf(chooser.getSelectedFile());
    System.out.println("getCurrentDirectory(): " + chooser.getCurrentDirectory());
    System.out.println("getSelectedFile() : " + selectedFile);
  } else {
    System.out.println("No Selection ");
    selectedFile = null;
  }

  return selectedFile;
}
