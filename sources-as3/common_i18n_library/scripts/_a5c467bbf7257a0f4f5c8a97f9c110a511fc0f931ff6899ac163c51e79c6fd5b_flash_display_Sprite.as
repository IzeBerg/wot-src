package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a5c467bbf7257a0f4f5c8a97f9c110a511fc0f931ff6899ac163c51e79c6fd5b_flash_display_Sprite extends Sprite
   {
       
      
      public function _a5c467bbf7257a0f4f5c8a97f9c110a511fc0f931ff6899ac163c51e79c6fd5b_flash_display_Sprite()
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
