package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ac46a65fb880610da10da7ebeab392c8678ebaf097e0764a31802a3d088ed624_flash_display_Sprite extends Sprite
   {
       
      
      public function _ac46a65fb880610da10da7ebeab392c8678ebaf097e0764a31802a3d088ed624_flash_display_Sprite()
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
