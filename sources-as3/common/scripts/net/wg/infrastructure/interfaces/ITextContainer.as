package net.wg.infrastructure.interfaces
{
   public interface ITextContainer extends IUIComponentEx
   {
       
      
      function get textSize() : Number;
      
      function set textSize(param1:Number) : void;
      
      function get textAlign() : String;
      
      function set textAlign(param1:String) : void;
   }
}
