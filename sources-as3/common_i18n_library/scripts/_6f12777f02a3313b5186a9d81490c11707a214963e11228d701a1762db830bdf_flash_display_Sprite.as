package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6f12777f02a3313b5186a9d81490c11707a214963e11228d701a1762db830bdf_flash_display_Sprite extends Sprite
   {
       
      
      public function _6f12777f02a3313b5186a9d81490c11707a214963e11228d701a1762db830bdf_flash_display_Sprite()
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
