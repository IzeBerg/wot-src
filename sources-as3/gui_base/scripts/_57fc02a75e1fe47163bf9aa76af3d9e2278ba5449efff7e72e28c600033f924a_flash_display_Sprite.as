package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _57fc02a75e1fe47163bf9aa76af3d9e2278ba5449efff7e72e28c600033f924a_flash_display_Sprite extends Sprite
   {
       
      
      public function _57fc02a75e1fe47163bf9aa76af3d9e2278ba5449efff7e72e28c600033f924a_flash_display_Sprite()
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
