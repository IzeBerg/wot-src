package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e723d0b7d23c2f25b83c5e94bd80f9bcf7d3e50dad383d7ecc2c801a6bc293ba_flash_display_Sprite extends Sprite
   {
       
      
      public function _e723d0b7d23c2f25b83c5e94bd80f9bcf7d3e50dad383d7ecc2c801a6bc293ba_flash_display_Sprite()
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
