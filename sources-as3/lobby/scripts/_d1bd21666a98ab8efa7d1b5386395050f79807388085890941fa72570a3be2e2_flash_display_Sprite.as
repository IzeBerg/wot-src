package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d1bd21666a98ab8efa7d1b5386395050f79807388085890941fa72570a3be2e2_flash_display_Sprite extends Sprite
   {
       
      
      public function _d1bd21666a98ab8efa7d1b5386395050f79807388085890941fa72570a3be2e2_flash_display_Sprite()
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
