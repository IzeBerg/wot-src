package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _cc277894bca6f97244183a25493308753d37f00412ac7f3a2c75e025db351b00_flash_display_Sprite extends Sprite
   {
       
      
      public function _cc277894bca6f97244183a25493308753d37f00412ac7f3a2c75e025db351b00_flash_display_Sprite()
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
