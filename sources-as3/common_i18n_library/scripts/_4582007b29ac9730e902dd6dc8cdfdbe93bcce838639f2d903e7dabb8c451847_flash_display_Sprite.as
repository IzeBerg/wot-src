package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4582007b29ac9730e902dd6dc8cdfdbe93bcce838639f2d903e7dabb8c451847_flash_display_Sprite extends Sprite
   {
       
      
      public function _4582007b29ac9730e902dd6dc8cdfdbe93bcce838639f2d903e7dabb8c451847_flash_display_Sprite()
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
