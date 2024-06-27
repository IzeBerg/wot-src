package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _282187a06b763f14010d3c2d36f1fcc268a7b128b170823d71c8733f5d7384a2_flash_display_Sprite extends Sprite
   {
       
      
      public function _282187a06b763f14010d3c2d36f1fcc268a7b128b170823d71c8733f5d7384a2_flash_display_Sprite()
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
