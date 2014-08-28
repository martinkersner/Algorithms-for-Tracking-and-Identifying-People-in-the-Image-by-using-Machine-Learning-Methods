package kersner;

import org.opencv.core.Point;
import java.util.List;

/**
 * eclub.cvutmedialab.cz 
 * surmon.org/summer-camp-2014/martin-kersner/
 * @author Martin Kersner
 * @date 08-28-2014
 */
public class Human {

    private final int id; // id of human
    private Point currentPos; // actual position
    private boolean gender; // 0 male, 1 female
    private List<Point> allPos; // log of all positions

    public Human(int id, double x, double y) {
        this.id = id;
        this.currentPos.x = x;
        this.currentPos.y = y;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }
    
    public void addPosition(double x, double y) {
        // change current position
        this.currentPos.x = x;
        this.currentPos.y = y;
        
        // add position to log
        Point p = new Point(x, y);
        this.allPos.add(p);
    }
}
