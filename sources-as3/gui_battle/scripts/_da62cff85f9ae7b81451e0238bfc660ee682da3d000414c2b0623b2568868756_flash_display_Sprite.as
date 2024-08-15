package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _da62cff85f9ae7b81451e0238bfc660ee682da3d000414c2b0623b2568868756_flash_display_Sprite extends Sprite
   {
       
      
      public function _da62cff85f9ae7b81451e0238bfc660ee682da3d000414c2b0623b2568868756_flash_display_Sprite()
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
