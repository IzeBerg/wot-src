package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _671bd69a8264d3fce5e2c8fb2299fa9acef7a8b4cd1bbc9a34105915d3733f1b_flash_display_Sprite extends Sprite
   {
       
      
      public function _671bd69a8264d3fce5e2c8fb2299fa9acef7a8b4cd1bbc9a34105915d3733f1b_flash_display_Sprite()
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
