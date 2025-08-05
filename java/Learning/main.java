// Java Program to show the use of
// Instance Variables
import java.io.*;

class Geeks {

    // Declared Instance Variable
    public String geek;
    public int i;
    public Integer I;
    public Geeks()
    {
        // Default Constructor
        // initializing Instance Variable
        this.geek = "Sweta Dash";
    }

    // Main Method
    public static void main(String[] args)
    {
        // Object Creation
        Geeks name = new Geeks();

        // Displaying O/P
        System.out.println("Geek name is: " + name.geek);
        System.out.println("Default value for int is "+ name.i);
      
        // toString() called internally
        System.out.println("Default value for Integer is: "+ name.I);
    }
}