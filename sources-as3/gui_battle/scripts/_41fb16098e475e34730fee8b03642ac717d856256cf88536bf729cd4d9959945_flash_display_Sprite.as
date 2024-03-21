package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _41fb16098e475e34730fee8b03642ac717d856256cf88536bf729cd4d9959945_flash_display_Sprite extends Sprite
   {
       
      
      public function _41fb16098e475e34730fee8b03642ac717d856256cf88536bf729cd4d9959945_flash_display_Sprite()
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
