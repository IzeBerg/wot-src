package net.wg.utils
{
   public interface INations
   {
       
      
      function getNationName(param1:uint) : String;
      
      function getNationIcon(param1:int) : String;
      
      function getNationID(param1:String) : uint;
      
      function getNations() : Array;
      
      function getNationsData() : Array;
   }
}
