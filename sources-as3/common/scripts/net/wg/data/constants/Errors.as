package net.wg.data.constants
{
   public class Errors
   {
      
      public static const MUST_NULL:String = " must be null.";
      
      public static const MUST_BE_ARRAY:String = " must be an Array";
      
      public static const MUST_REGISTER:String = " component must registered before unregistering.";
      
      public static const ALREADY_REGISTERED:String = " component already registered.";
      
      public static const WASNT_UNREGISTERED:String = "object was not unregistered until destroying: ";
      
      public static const CANT_NULL:String = " can`t be null.";
      
      public static const CANT_NAN:String = " can`t be NaN.";
      
      public static const CANT_EMPTY:String = " can`t empty.";
      
      public static const WASNT_FOUND:String = " was not found.";
      
      public static const BAD_LINKAGE:String = "Error extracting object with linkage: ";
      
      public static const ABSTRACT_INVOKE:String = " abstract method can`t be invoked.";
      
      public static const MTHD_CORRUPT_INVOKE:String = "method invoking after object destruction";
      
      public static const INVALID_FOCUS_USING:String = "Unsafe using App.utils.focusHandler.setFocus. \n\"" + "It can damage the focus system functionality. Please, use in view, as like as:\n" + "\tthis.setFocus(form.header.closeButton). ";
      
      public static const INVALID_TYPE:String = "Type must be: ";
      
      public static const ALREADY_DISPOSED:String = "Already Disposed";
      
      public static const WRONG_VALUE:String = "Wrong value";
       
      
      public function Errors()
      {
         super();
      }
   }
}
