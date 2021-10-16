package net.wg.infrastructure.interfaces
{
   public interface IViewPort extends IUIComponentEx
   {
       
      
      function get horizontalScrollPosition() : Number;
      
      function set horizontalScrollPosition(param1:Number) : void;
      
      function get verticalScrollPosition() : Number;
      
      function set verticalScrollPosition(param1:Number) : void;
      
      function get visibleWidth() : Number;
      
      function set visibleWidth(param1:Number) : void;
      
      function get visibleHeight() : Number;
      
      function set visibleHeight(param1:Number) : void;
      
      function get validWidth() : Number;
      
      function get validHeight() : Number;
   }
}
