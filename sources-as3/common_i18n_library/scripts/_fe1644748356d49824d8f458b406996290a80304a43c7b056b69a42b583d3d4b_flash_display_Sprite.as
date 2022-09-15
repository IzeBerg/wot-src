package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fe1644748356d49824d8f458b406996290a80304a43c7b056b69a42b583d3d4b_flash_display_Sprite extends Sprite
   {
       
      
      public function _fe1644748356d49824d8f458b406996290a80304a43c7b056b69a42b583d3d4b_flash_display_Sprite()
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
