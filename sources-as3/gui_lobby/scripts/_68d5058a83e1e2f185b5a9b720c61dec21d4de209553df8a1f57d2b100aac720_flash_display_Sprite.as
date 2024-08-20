package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _68d5058a83e1e2f185b5a9b720c61dec21d4de209553df8a1f57d2b100aac720_flash_display_Sprite extends Sprite
   {
       
      
      public function _68d5058a83e1e2f185b5a9b720c61dec21d4de209553df8a1f57d2b100aac720_flash_display_Sprite()
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
