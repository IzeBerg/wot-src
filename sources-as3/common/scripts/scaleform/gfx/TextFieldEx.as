package scaleform.gfx
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   
   public final class TextFieldEx extends InteractiveObjectEx
   {
      
      public static const VALIGN_NONE:String = "none";
      
      public static const VALIGN_TOP:String = "top";
      
      public static const VALIGN_CENTER:String = "center";
      
      public static const VALIGN_BOTTOM:String = "bottom";
      
      public static const TEXTAUTOSZ_NONE:String = "none";
      
      public static const TEXTAUTOSZ_SHRINK:String = "shrink";
      
      public static const TEXTAUTOSZ_FIT:String = "fit";
      
      public static const VAUTOSIZE_NONE:String = "none";
      
      public static const VAUTOSIZE_TOP:String = "top";
      
      public static const VAUTOSIZE_CENTER:String = "center";
      
      public static const VAUTOSIZE_BOTTOM:String = "bottom";
       
      
      public function TextFieldEx()
      {
         super();
      }
      
      public static function appendHtml(param1:TextField, param2:String) : void
      {
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
      }
      
      public static function setVerticalAlign(param1:TextField, param2:String) : void
      {
      }
      
      public static function getVerticalAlign(param1:TextField) : String
      {
         return "none";
      }
      
      public static function setVerticalAutoSize(param1:TextField, param2:String) : void
      {
      }
      
      public static function getVerticalAutoSize(param1:TextField) : String
      {
         return "none";
      }
      
      public static function setTextAutoSize(param1:TextField, param2:String) : void
      {
      }
      
      public static function getTextAutoSize(param1:TextField) : String
      {
         return "none";
      }
      
      public static function setImageSubstitutions(param1:TextField, param2:Object) : void
      {
      }
      
      public static function updateImageSubstitution(param1:TextField, param2:String, param3:BitmapData) : void
      {
      }
      
      public static function setNoTranslate(param1:TextField, param2:Boolean) : void
      {
      }
      
      public static function getNoTranslate(param1:TextField) : Boolean
      {
         return false;
      }
      
      public static function setBidirectionalTextEnabled(param1:TextField, param2:Boolean) : void
      {
      }
      
      public static function getBidirectionalTextEnabled(param1:TextField) : Boolean
      {
         return false;
      }
      
      public static function setSelectionTextColor(param1:TextField, param2:uint) : void
      {
      }
      
      public static function getSelectionTextColor(param1:TextField) : uint
      {
         return 4294967295;
      }
      
      public static function setSelectionBkgColor(param1:TextField, param2:uint) : void
      {
      }
      
      public static function getSelectionBkgColor(param1:TextField) : uint
      {
         return 4278190080;
      }
      
      public static function setInactiveSelectionTextColor(param1:TextField, param2:uint) : void
      {
      }
      
      public static function getInactiveSelectionTextColor(param1:TextField) : uint
      {
         return 4294967295;
      }
      
      public static function setInactiveSelectionBkgColor(param1:TextField, param2:uint) : void
      {
      }
      
      public static function getInactiveSelectionBkgColor(param1:TextField) : uint
      {
         return 4278190080;
      }
      
      public static function setForceVector(param1:TextField, param2:Boolean) : void
      {
      }
      
      public static function getForceVector(param1:TextField) : uint
      {
         return 0;
      }
   }
}
