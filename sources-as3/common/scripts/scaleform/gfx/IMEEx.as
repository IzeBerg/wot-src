package scaleform.gfx
{
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   
   public final class IMEEx extends EventDispatcher
   {
       
      
      public function IMEEx()
      {
         super();
      }
      
      public static function getIMECandidateListStyle() : IMECandidateListStyle
      {
         return null;
      }
      
      public static function setIMECandidateListStyle(param1:IMECandidateListStyle) : void
      {
      }
      
      public static function SendLangBarMessage(param1:Sprite, param2:String, param3:String) : void
      {
      }
      
      public static function GetOSVersion() : String
      {
         return null;
      }
   }
}
