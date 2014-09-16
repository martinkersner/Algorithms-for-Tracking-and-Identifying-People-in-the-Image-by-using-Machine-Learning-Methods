package kersner;

import org.opencv.core.*;
import org.opencv.highgui.Highgui;
import com.atul.JavaOpenCV.Imshow;
import java.io.IOException;
import java.util.List;

public class Main {

    public static void main(String[] args) throws IOException {

        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

        //String imgFilename = "1A.png"; // 4
        String imgFilename = "2A.png"; // 7
        
        String maskFilename = "mask.png";

        Mat mask = Highgui.imread(maskFilename, CvType.CV_8U);
        Mat img = Highgui.imread(imgFilename, CvType.CV_8U);        

        // settings
        int maxValue = 255; // max intensity value of grayscale image
        int nbins = 20; // number of bins
        
        //DataHandler dataHandler = new DataHandler();        
        //Mat data = dataHandler.readCsv("data.csv");
        //Mat trainLabels = dataHandler.getLabel(data);
        //Mat trainData = dataHandler.getData(data);  
        //Recognizer recognizer = new Recognizer(trainLabels, trainData);
                
        // ORIENTATION
        Recognizer orientation = new Recognizer();
        orientation.imgHeight = img.rows();
        orientation.imgWidth = img.cols();
        
        // LOAD MODEL
        String modelFileName = "model.xml";
        orientation.loadModel(modelFileName);
        
        // CREATE AND SAVE MODEL
        //orientation.createModel("/folder/");

        // IMAGE PREPROCESSING
        Mat filt = orientation.maskFilter(img, mask, nbins, maxValue);
        orientation.detect(filt, nbins, maxValue);
        
        // USE MODEL
        float direction = orientation.predict(orientation.hogFeatures);
        System.out.println(direction);
        
        ////////////////////////////////////////////////////////////////////////
        
        // GENDER
        imgFilename = "head1.png";
        //imgFilename = "head2.png";
        Mat img2 = Highgui.imread(imgFilename, CvType.CV_8U); 
        
        Recognizer gender = new Recognizer();
        gender.paddHeightMax = 71;
        gender.paddWidthMax = 71;
        gender.createModel("/folder2/");
        
        // create cells
        List<Rect> cells = gender.genBlocks(71, 71, 6, 6);

        // create blocks
        List<Rect> blocks = gender.genBlocks((int) Math.floor(71 / 6), (int) Math.floor(71 / 6) * 9, 3, 3 * 9);
        
        float g = gender.predict(gender.hog(img2, cells, blocks));
        System.out.println(g);
        
        ////////////////////////////////////////////////////////////////////////
        
        Imshow im = new Imshow("GUI");
        im.showImage(img);
    }
}
