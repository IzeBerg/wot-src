package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _15f0ece68aeb598b08d5dd6234527c93dabfde304d99752ec26c0e8d97dc092e_flash_display_Sprite extends Sprite
   {
       
      
      public function _15f0ece68aeb598b08d5dd6234527c93dabfde304d99752ec26c0e8d97dc092e_flash_display_Sprite()
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
