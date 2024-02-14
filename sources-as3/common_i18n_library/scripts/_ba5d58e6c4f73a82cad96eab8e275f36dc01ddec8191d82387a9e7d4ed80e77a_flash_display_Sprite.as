package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ba5d58e6c4f73a82cad96eab8e275f36dc01ddec8191d82387a9e7d4ed80e77a_flash_display_Sprite extends Sprite
   {
       
      
      public function _ba5d58e6c4f73a82cad96eab8e275f36dc01ddec8191d82387a9e7d4ed80e77a_flash_display_Sprite()
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
