package scaleform.gfx
{
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   
   public final class FocusManager
   {
       
      
      public function FocusManager()
      {
         super();
      }
      
      public static function set alwaysEnableArrowKeys(param1:Boolean) : void
      {
      }
      
      public static function get alwaysEnableArrowKeys() : Boolean
      {
         return false;
      }
      
      public static function set disableFocusKeys(param1:Boolean) : void
      {
      }
      
      public static function get disableFocusKeys() : Boolean
      {
         return false;
      }
      
      public static function moveFocus(param1:String, param2:InteractiveObject = null, param3:Boolean = false, param4:uint = 0) : InteractiveObject
      {
         return null;
      }
      
      public static function findFocus(param1:String, param2:DisplayObjectContainer = null, param3:Boolean = false, param4:InteractiveObject = null, param5:Boolean = false, param6:uint = 0) : InteractiveObject
      {
         return null;
      }
      
      public static function setFocus(param1:InteractiveObject, param2:uint = 0) : void
      {
      }
      
      public static function getFocus(param1:uint = 0) : InteractiveObject
      {
         return null;
      }
      
      public static function get numFocusGroups() : uint
      {
         return 1;
      }
      
      public static function setFocusGroupMask(param1:InteractiveObject, param2:uint) : void
      {
      }
      
      public static function getFocusGroupMask(param1:InteractiveObject) : uint
      {
         return 1;
      }
      
      public static function setControllerFocusGroup(param1:uint, param2:uint) : Boolean
      {
         return false;
      }
      
      public static function getControllerFocusGroup(param1:uint) : uint
      {
         return 0;
      }
      
      public static function getControllerMaskByFocusGroup(param1:uint) : uint
      {
         return 0;
      }
      
      public static function getModalClip(param1:uint = 0) : Sprite
      {
         return null;
      }
      
      public static function setModalClip(param1:Sprite, param2:uint = 0) : void
      {
      }
   }
}
