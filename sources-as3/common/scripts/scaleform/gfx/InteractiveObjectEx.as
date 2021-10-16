package scaleform.gfx
{
   import flash.display.InteractiveObject;
   
   public class InteractiveObjectEx extends DisplayObjectEx
   {
       
      
      public function InteractiveObjectEx()
      {
         super();
      }
      
      public static function setHitTestDisable(param1:InteractiveObject, param2:Boolean) : void
      {
      }
      
      public static function getHitTestDisable(param1:InteractiveObject) : Boolean
      {
         return false;
      }
      
      public static function setTopmostLevel(param1:InteractiveObject, param2:Boolean) : void
      {
      }
      
      public static function getTopmostLevel(param1:InteractiveObject) : Boolean
      {
         return false;
      }
   }
}
