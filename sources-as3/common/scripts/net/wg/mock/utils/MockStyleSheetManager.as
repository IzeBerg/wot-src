package net.wg.mock.utils
{
   import flash.text.TextField;
   import net.wg.utils.IStyleSheetManager;
   
   public class MockStyleSheetManager implements IStyleSheetManager
   {
       
      
      public function MockStyleSheetManager()
      {
         super();
      }
      
      public function setForceFocusedStyle(param1:String) : String
      {
         return "";
      }
      
      public function setLinkStyle(param1:TextField) : void
      {
      }
   }
}
