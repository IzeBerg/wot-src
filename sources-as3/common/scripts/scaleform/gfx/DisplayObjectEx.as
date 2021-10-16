package scaleform.gfx
{
   import flash.display.DisplayObject;
   
   public class DisplayObjectEx
   {
       
      
      public function DisplayObjectEx()
      {
         super();
      }
      
      public static function disableBatching(param1:DisplayObject, param2:Boolean) : void
      {
      }
      
      public static function isBatchingDisabled(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      public static function setRendererString(param1:DisplayObject, param2:String) : void
      {
      }
      
      public static function getRendererString(param1:DisplayObject) : String
      {
         return null;
      }
      
      public static function setRendererFloat(param1:DisplayObject, param2:Number) : void
      {
      }
      
      public static function getRendererFloat(param1:DisplayObject) : Number
      {
         return Number.NaN;
      }
   }
}
