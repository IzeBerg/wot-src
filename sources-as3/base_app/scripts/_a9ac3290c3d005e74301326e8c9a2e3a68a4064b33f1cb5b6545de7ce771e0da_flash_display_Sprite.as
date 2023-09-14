package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a9ac3290c3d005e74301326e8c9a2e3a68a4064b33f1cb5b6545de7ce771e0da_flash_display_Sprite extends Sprite
   {
       
      
      public function _a9ac3290c3d005e74301326e8c9a2e3a68a4064b33f1cb5b6545de7ce771e0da_flash_display_Sprite()
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
