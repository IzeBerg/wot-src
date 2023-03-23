package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f9e85e40841724b1116c9a104a195b4802824299cd8f15941ef144db39fec910_flash_display_Sprite extends Sprite
   {
       
      
      public function _f9e85e40841724b1116c9a104a195b4802824299cd8f15941ef144db39fec910_flash_display_Sprite()
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
