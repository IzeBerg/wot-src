package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d1aa458cc5615399d376f54c15b5a3e96f352c27ddd255306ed4e74ba293a159_flash_display_Sprite extends Sprite
   {
       
      
      public function _d1aa458cc5615399d376f54c15b5a3e96f352c27ddd255306ed4e74ba293a159_flash_display_Sprite()
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
