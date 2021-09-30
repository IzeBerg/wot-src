package net.wg.gui.interfaces
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IHeaderButtonContentItem extends IUIComponentEx
   {
       
      
      function updateScreen(param1:String, param2:Number, param3:Number) : void;
      
      function setAvailableWidth(param1:Number) : void;
      
      function updateButtonBounds(param1:Rectangle) : void;
      
      function onPopoverClose() : void;
      
      function onPopoverOpen() : void;
      
      function getSeparatorType() : String;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get screen() : String;
      
      function get readyToShow() : Boolean;
      
      function set readyToShow(param1:Boolean) : void;
   }
}
