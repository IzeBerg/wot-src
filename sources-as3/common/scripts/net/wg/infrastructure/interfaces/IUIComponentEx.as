package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;
   
   public interface IUIComponentEx extends IUIComponent
   {
       
      
      [Inspectable(defaultValue="false")]
      function setActualSize(param1:Number, param2:Number) : void;
      
      function setActualScale(param1:Number, param2:Number) : void;
      
      function invalidate(... rest) : void;
      
      function setSize(param1:Number, param2:Number) : void;
      
      function get enableInitCallback() : Boolean;
      
      function set enableInitCallback(param1:Boolean) : void;
      
      function get actualWidth() : Number;
      
      function get actualHeight() : Number;
      
      function get actualScaleX() : Number;
      
      function get actualScaleY() : Number;
   }
}
