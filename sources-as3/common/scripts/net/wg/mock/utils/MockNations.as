package net.wg.mock.utils
{
   import net.wg.utils.INations;
   
   public class MockNations implements INations
   {
       
      
      public function MockNations()
      {
         super();
      }
      
      public function getNationID(param1:String) : uint
      {
         return 0;
      }
      
      public function getNationIcon(param1:int) : String
      {
         return "";
      }
      
      public function getNationName(param1:uint) : String
      {
         return "";
      }
      
      public function getNations() : Array
      {
         return null;
      }
      
      public function getNationsData() : Array
      {
         return null;
      }
   }
}
