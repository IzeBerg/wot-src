package net.wg.utils
{
   import flash.text.TextField;
   
   public interface ITextManager
   {
       
      
      function setDefTextSelection(param1:TextField) : void;
      
      function createTextField() : TextField;
      
      function getTextStyleById(param1:String, param2:String) : String;
   }
}
