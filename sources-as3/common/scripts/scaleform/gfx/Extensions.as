package scaleform.gfx
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public final class Extensions
   {
      
      public static const EDGEAA_INHERIT:uint = 0;
      
      public static const EDGEAA_ON:uint = 1;
      
      public static const EDGEAA_OFF:uint = 2;
      
      public static const EDGEAA_DISABLE:uint = 3;
      
      public static var isGFxPlayer:Boolean = false;
      
      public static var CLIK_addedToStageCallback:Function;
      
      public static var gfxProcessSound:Function;
       
      
      public function Extensions()
      {
         super();
      }
      
      public static function set enabled(param1:Boolean) : void
      {
      }
      
      public static function get enabled() : Boolean
      {
         return false;
      }
      
      public static function set noInvisibleAdvance(param1:Boolean) : void
      {
      }
      
      public static function get noInvisibleAdvance() : Boolean
      {
         return false;
      }
      
      public static function getTopMostEntity(param1:Number, param2:Number, param3:Boolean = true) : DisplayObject
      {
         return null;
      }
      
      public static function getMouseTopMostEntity(param1:Boolean = true, param2:uint = 0) : DisplayObject
      {
         return null;
      }
      
      public static function setMouseCursorType(param1:String, param2:uint = 0) : void
      {
      }
      
      public static function getMouseCursorType(param1:uint = 0) : String
      {
         return "";
      }
      
      public static function get numControllers() : uint
      {
         return 1;
      }
      
      public static function get visibleRect() : Rectangle
      {
         return new Rectangle(0,0,0,0);
      }
      
      public static function getEdgeAAMode(param1:DisplayObject) : uint
      {
         return EDGEAA_INHERIT;
      }
      
      public static function setEdgeAAMode(param1:DisplayObject, param2:uint) : void
      {
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
      }
      
      public static function get isScaleform() : Boolean
      {
         return false;
      }
   }
}
