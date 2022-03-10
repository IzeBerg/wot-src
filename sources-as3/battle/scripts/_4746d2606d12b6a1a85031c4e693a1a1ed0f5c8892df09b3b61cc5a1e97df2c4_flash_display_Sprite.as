package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4746d2606d12b6a1a85031c4e693a1a1ed0f5c8892df09b3b61cc5a1e97df2c4_flash_display_Sprite extends Sprite
   {
       
      
      public function _4746d2606d12b6a1a85031c4e693a1a1ed0f5c8892df09b3b61cc5a1e97df2c4_flash_display_Sprite()
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
