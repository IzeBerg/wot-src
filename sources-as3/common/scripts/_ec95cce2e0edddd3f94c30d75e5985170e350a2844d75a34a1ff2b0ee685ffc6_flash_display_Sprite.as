package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ec95cce2e0edddd3f94c30d75e5985170e350a2844d75a34a1ff2b0ee685ffc6_flash_display_Sprite extends Sprite
   {
       
      
      public function _ec95cce2e0edddd3f94c30d75e5985170e350a2844d75a34a1ff2b0ee685ffc6_flash_display_Sprite()
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
