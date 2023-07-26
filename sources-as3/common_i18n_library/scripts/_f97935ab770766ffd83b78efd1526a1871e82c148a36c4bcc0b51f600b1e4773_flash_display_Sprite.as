package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f97935ab770766ffd83b78efd1526a1871e82c148a36c4bcc0b51f600b1e4773_flash_display_Sprite extends Sprite
   {
       
      
      public function _f97935ab770766ffd83b78efd1526a1871e82c148a36c4bcc0b51f600b1e4773_flash_display_Sprite()
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
