package net.wg.gui.components.carousels.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IScrollerBase extends IUIComponentEx
   {
       
      
      function moveToHorizontalScrollPosition(param1:int) : void;
      
      function get horizontalScrollPosition() : Number;
      
      function set horizontalScrollPosition(param1:Number) : void;
      
      function get verticalScrollPosition() : Number;
      
      function set verticalScrollPosition(param1:Number) : void;
      
      function get horizontalScrollStep() : Number;
      
      function set horizontalScrollStep(param1:Number) : void;
      
      function get verticalScrollStep() : Number;
      
      function set verticalScrollStep(param1:Number) : void;
      
      function get minHorizontalScrollPosition() : Number;
      
      function get minVerticalScrollPosition() : Number;
      
      function get maxHorizontalScrollPosition() : Number;
      
      function get maxVerticalScrollPosition() : Number;
      
      function get mouseWheelDirection() : String;
      
      function set mouseWheelDirection(param1:String) : void;
      
      function get pageWidth() : Number;
      
      function set pageWidth(param1:Number) : void;
      
      function get pageHeight() : Number;
      
      function set pageHeight(param1:Number) : void;
      
      function get maskOffsetLeft() : Number;
      
      function set maskOffsetLeft(param1:Number) : void;
      
      function get maskOffsetRight() : Number;
      
      function set maskOffsetRight(param1:Number) : void;
      
      function get maskOffsetTop() : Number;
      
      function set maskOffsetTop(param1:Number) : void;
      
      function get maskOffsetBottom() : Number;
      
      function set maskOffsetBottom(param1:Number) : void;
      
      function get useTimer() : Boolean;
      
      function set useTimer(param1:Boolean) : void;
      
      function set hasHorizontalElasticEdges(param1:Boolean) : void;
      
      function get hasVerticalElasticEdges() : Boolean;
      
      function set hasVerticalElasticEdges(param1:Boolean) : void;
      
      function get mouseWheelEnabled() : Boolean;
      
      function set mouseWheelEnabled(param1:Boolean) : void;
      
      function get touchScrollEnabled() : Boolean;
      
      function set touchScrollEnabled(param1:Boolean) : void;
      
      function get viewPort() : IScrollerViewPortBase;
      
      function set viewPort(param1:IScrollerViewPortBase) : void;
      
      function get snapScrollPositionToPixels() : Boolean;
      
      function set snapScrollPositionToPixels(param1:Boolean) : void;
      
      function get paddingTop() : int;
      
      function set paddingTop(param1:int) : void;
      
      function get paddingLeft() : int;
      
      function set paddingLeft(param1:int) : void;
      
      function get paddingRight() : int;
      
      function set paddingRight(param1:int) : void;
      
      function get paddingBottom() : int;
      
      function set paddingBottom(param1:int) : void;
   }
}
