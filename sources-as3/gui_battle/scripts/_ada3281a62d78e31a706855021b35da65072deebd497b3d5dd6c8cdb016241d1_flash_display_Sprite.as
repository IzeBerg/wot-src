package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ada3281a62d78e31a706855021b35da65072deebd497b3d5dd6c8cdb016241d1_flash_display_Sprite extends Sprite
   {
       
      
      public function _ada3281a62d78e31a706855021b35da65072deebd497b3d5dd6c8cdb016241d1_flash_display_Sprite()
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
