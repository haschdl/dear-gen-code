import java.util.*;
import java.lang.reflect.Field;



class Params {
  
  int maxframes, alpha, n, res;
  float maxspeed, maxforce;


  //From: https://stackoverflow.com/a/1526843
  String toString() {
    StringBuilder result = new StringBuilder();
    String newLine = System.getProperty("line.separator");

    //Uncomment if you want to print the class name.
    //result.append( this.getClass().getName() );
    //result.append( " Object {" );
    //result.append(newLine);

    //determine fields declared in this class only (no fields of superclass)
    Field[] fields = this.getClass().getDeclaredFields();

    //print field names paired with their values
    for ( Field field : fields  ) {      
      try {
        if (field.getName().startsWith("this"))
          continue;

        result.append( field.getName() );
        result.append(":");
        //requires access to private field:
        result.append( field.get(this) );
        result.append(", ");
      } 
      catch ( IllegalAccessException ex ) {
        System.out.println(ex);
      }
      
      //result.append(newLine);
    }
    //result.append("}");

    return result.toString().substring(0,result.length()-2);
  }
}
