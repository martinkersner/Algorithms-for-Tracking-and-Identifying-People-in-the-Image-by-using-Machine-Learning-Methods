package kersner;

import au.com.bytecode.opencsv.CSVReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfFloat;
import org.opencv.core.Rect;

/**
 * eclub.cvutmedialab.cz
 * surmon.org/summer-camp-2014/martin-kersner/
 * @author Martin Kersner
 * @date 08-28-2014
 */
public class DataHandler {

    public Mat getLabel(Mat m) {
        // get size of Mat
        int rows = m.rows();
        
        Rect trainRect = new Rect(0, 0, 1, rows);

        return m.submat(trainRect);
    }

    public Mat getData(Mat m) {
        // get size of Mat
        int rows = m.rows();
        int cols = m.cols();

        Rect trainRect = new Rect(1, 0, cols - 1, rows);

        return m.submat(trainRect);
    }

    public Mat readCsv(String filename) throws FileNotFoundException, IOException {
        // get size of csv file
        CSVReader reader = new CSVReader(new FileReader(filename));
        int cols = reader.readNext().length;
        int rows = reader.readAll().size() + 1;

        // set up size and type of ouput Mat
        // training/testing data need to be stored in Mat of type CV_32FC1
        Mat data = new Mat(0, 0, CvType.CV_32FC1);

        // read again
        reader = new CSVReader(new FileReader(filename));
        String[] nextLine;

        Mat dataTmp;

        while ((nextLine = reader.readNext()) != null) {
            List<Mat> listData = new ArrayList<>();
            
            for (String s : nextLine) {
                listData.add(new MatOfFloat(Float.parseFloat(s)));
            }

            dataTmp = new Mat(1, cols, CvType.CV_32FC1);
            Core.hconcat(listData, dataTmp);
            data.push_back(dataTmp);
        }

        return data;
    }
}
