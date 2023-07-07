package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9ad9c98be2f366c53e802181aa011faa9d7c04cc911ad96290615a731b14ccaa_flash_display_Sprite extends Sprite
   {
       
      
      public function _9ad9c98be2f366c53e802181aa011faa9d7c04cc911ad96290615a731b14ccaa_flash_display_Sprite()
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
