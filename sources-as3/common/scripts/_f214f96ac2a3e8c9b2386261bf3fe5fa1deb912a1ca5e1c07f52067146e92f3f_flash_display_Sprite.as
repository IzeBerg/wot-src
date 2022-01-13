package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f214f96ac2a3e8c9b2386261bf3fe5fa1deb912a1ca5e1c07f52067146e92f3f_flash_display_Sprite extends Sprite
   {
       
      
      public function _f214f96ac2a3e8c9b2386261bf3fe5fa1deb912a1ca5e1c07f52067146e92f3f_flash_display_Sprite()
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
