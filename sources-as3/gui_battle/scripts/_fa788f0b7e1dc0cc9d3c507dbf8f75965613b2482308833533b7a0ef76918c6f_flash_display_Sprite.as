package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fa788f0b7e1dc0cc9d3c507dbf8f75965613b2482308833533b7a0ef76918c6f_flash_display_Sprite extends Sprite
   {
       
      
      public function _fa788f0b7e1dc0cc9d3c507dbf8f75965613b2482308833533b7a0ef76918c6f_flash_display_Sprite()
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
