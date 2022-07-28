package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7a7c239a63a5e37cc4cdd4e5ee719d2446a909102467ebd7235c38dadfd21b33_flash_display_Sprite extends Sprite
   {
       
      
      public function _7a7c239a63a5e37cc4cdd4e5ee719d2446a909102467ebd7235c38dadfd21b33_flash_display_Sprite()
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
