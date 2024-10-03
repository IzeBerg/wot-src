package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6a7b867f00e1ba98a185ab93daea4d909dd8b21215df2a5c13b02d5a3643d6a6_flash_display_Sprite extends Sprite
   {
       
      
      public function _6a7b867f00e1ba98a185ab93daea4d909dd8b21215df2a5c13b02d5a3643d6a6_flash_display_Sprite()
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
