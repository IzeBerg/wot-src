package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d6dab7101f10693b118a0500724cacbc7c0897f5bfa74ca40a16b1a778e55f1d_flash_display_Sprite extends Sprite
   {
       
      
      public function _d6dab7101f10693b118a0500724cacbc7c0897f5bfa74ca40a16b1a778e55f1d_flash_display_Sprite()
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
