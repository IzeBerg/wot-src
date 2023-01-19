package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _12d2ca67405a3602449e6994c84342cd352d79d6108afb6f0c01744c24a35015_flash_display_Sprite extends Sprite
   {
       
      
      public function _12d2ca67405a3602449e6994c84342cd352d79d6108afb6f0c01744c24a35015_flash_display_Sprite()
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
