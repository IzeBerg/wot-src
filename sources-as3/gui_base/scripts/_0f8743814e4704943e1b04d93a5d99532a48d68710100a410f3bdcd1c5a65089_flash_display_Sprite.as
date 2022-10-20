package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0f8743814e4704943e1b04d93a5d99532a48d68710100a410f3bdcd1c5a65089_flash_display_Sprite extends Sprite
   {
       
      
      public function _0f8743814e4704943e1b04d93a5d99532a48d68710100a410f3bdcd1c5a65089_flash_display_Sprite()
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
