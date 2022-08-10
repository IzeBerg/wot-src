package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _44c706f8a22f3f7443a397f98c45a01fef0b9fd8e07c2c82f849ddc6443d1fbb_flash_display_Sprite extends Sprite
   {
       
      
      public function _44c706f8a22f3f7443a397f98c45a01fef0b9fd8e07c2c82f849ddc6443d1fbb_flash_display_Sprite()
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
