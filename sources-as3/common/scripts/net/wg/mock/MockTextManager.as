package net.wg.mock
{
   import flash.text.TextField;
   import net.wg.utils.ITextManager;
   
   public class MockTextManager implements ITextManager
   {
       
      
      public function MockTextManager()
      {
         super();
      }
      
      public function createTextField() : TextField
      {
         return null;
      }
      
      public function getTextStyleById(param1:String, param2:String) : String
      {
         return "";
      }
      
      public function setDefTextSelection(param1:TextField) : void
      {
      }
   }
}
