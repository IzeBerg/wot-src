package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _850acec2f699c91606e2d1bd8bb0679d7f95253634014420bbfb5fcd03213490_flash_display_Sprite extends Sprite
   {
       
      
      public function _850acec2f699c91606e2d1bd8bb0679d7f95253634014420bbfb5fcd03213490_flash_display_Sprite()
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
