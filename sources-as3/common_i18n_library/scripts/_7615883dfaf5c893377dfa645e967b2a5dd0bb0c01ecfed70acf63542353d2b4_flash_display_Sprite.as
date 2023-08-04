package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7615883dfaf5c893377dfa645e967b2a5dd0bb0c01ecfed70acf63542353d2b4_flash_display_Sprite extends Sprite
   {
       
      
      public function _7615883dfaf5c893377dfa645e967b2a5dd0bb0c01ecfed70acf63542353d2b4_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
