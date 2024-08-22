package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a43deb0b3d7e6ab11ae6022de9af65b7b22e4ae0875d0d0cd20177403e132ea9_flash_display_Sprite extends Sprite
   {
       
      
      public function _a43deb0b3d7e6ab11ae6022de9af65b7b22e4ae0875d0d0cd20177403e132ea9_flash_display_Sprite()
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
