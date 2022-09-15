package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8e61e4a02a8175d3d2118ac36c88e7eb968c96cd09cc9b586042dfcd5ee5dfa5_flash_display_Sprite extends Sprite
   {
       
      
      public function _8e61e4a02a8175d3d2118ac36c88e7eb968c96cd09cc9b586042dfcd5ee5dfa5_flash_display_Sprite()
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
