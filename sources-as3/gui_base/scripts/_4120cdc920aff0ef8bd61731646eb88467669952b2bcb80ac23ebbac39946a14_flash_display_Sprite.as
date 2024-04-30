package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4120cdc920aff0ef8bd61731646eb88467669952b2bcb80ac23ebbac39946a14_flash_display_Sprite extends Sprite
   {
       
      
      public function _4120cdc920aff0ef8bd61731646eb88467669952b2bcb80ac23ebbac39946a14_flash_display_Sprite()
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
