package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e4a92ae29bc0911c30e8f62dd8f499af95169987b9eaaee1e76ba29ca4b76813_flash_display_Sprite extends Sprite
   {
       
      
      public function _e4a92ae29bc0911c30e8f62dd8f499af95169987b9eaaee1e76ba29ca4b76813_flash_display_Sprite()
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
