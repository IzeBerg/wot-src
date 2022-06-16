package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9442f63a03c897f39e8817be8cdd31d0604a9d4dfdd78279e86261436a2f6750_flash_display_Sprite extends Sprite
   {
       
      
      public function _9442f63a03c897f39e8817be8cdd31d0604a9d4dfdd78279e86261436a2f6750_flash_display_Sprite()
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
