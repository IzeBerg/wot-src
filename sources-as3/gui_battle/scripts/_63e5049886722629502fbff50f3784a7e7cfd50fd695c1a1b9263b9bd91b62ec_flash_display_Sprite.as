package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _63e5049886722629502fbff50f3784a7e7cfd50fd695c1a1b9263b9bd91b62ec_flash_display_Sprite extends Sprite
   {
       
      
      public function _63e5049886722629502fbff50f3784a7e7cfd50fd695c1a1b9263b9bd91b62ec_flash_display_Sprite()
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
