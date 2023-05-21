package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1bd135bff93f06e6744469fc4d6bb4ead04b7af657ea6ee572248524308efe27_flash_display_Sprite extends Sprite
   {
       
      
      public function _1bd135bff93f06e6744469fc4d6bb4ead04b7af657ea6ee572248524308efe27_flash_display_Sprite()
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
