package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _92c7cf9213c39255ef3d0578a6d13ab780291548e470c8f9851bf82c07ab6c64_flash_display_Sprite extends Sprite
   {
       
      
      public function _92c7cf9213c39255ef3d0578a6d13ab780291548e470c8f9851bf82c07ab6c64_flash_display_Sprite()
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
