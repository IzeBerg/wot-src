package net.wg.app.iml.base
{
   import flash.events.Event;
   
   public class StageResizeEvent extends Event
   {
      
      public static const STAGE_RESIZE:String = "stageResize";
       
      
      private var _width:uint;
      
      private var _height:uint;
      
      private var _scale:Number;
      
      public function StageResizeEvent(param1:uint, param2:uint, param3:Number)
      {
         super(STAGE_RESIZE,false,false);
         this._width = param1;
         this._height = param2;
         this._scale = param3;
      }
      
      public function get width() : uint
      {
         return this._width;
      }
      
      public function get height() : uint
      {
         return this._height;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
   }
}
