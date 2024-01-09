package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9b1ea498affd5eeac0121278986951571f2b035f5d25e8561f6bb8bc8a0f6840_flash_display_Sprite extends Sprite
   {
       
      
      public function _9b1ea498affd5eeac0121278986951571f2b035f5d25e8561f6bb8bc8a0f6840_flash_display_Sprite()
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
