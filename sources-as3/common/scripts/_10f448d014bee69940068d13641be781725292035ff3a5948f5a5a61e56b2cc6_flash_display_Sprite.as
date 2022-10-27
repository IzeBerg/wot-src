package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _10f448d014bee69940068d13641be781725292035ff3a5948f5a5a61e56b2cc6_flash_display_Sprite extends Sprite
   {
       
      
      public function _10f448d014bee69940068d13641be781725292035ff3a5948f5a5a61e56b2cc6_flash_display_Sprite()
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
