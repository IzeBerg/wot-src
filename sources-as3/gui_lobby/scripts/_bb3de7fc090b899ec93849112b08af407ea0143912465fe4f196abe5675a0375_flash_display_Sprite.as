package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bb3de7fc090b899ec93849112b08af407ea0143912465fe4f196abe5675a0375_flash_display_Sprite extends Sprite
   {
       
      
      public function _bb3de7fc090b899ec93849112b08af407ea0143912465fe4f196abe5675a0375_flash_display_Sprite()
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
