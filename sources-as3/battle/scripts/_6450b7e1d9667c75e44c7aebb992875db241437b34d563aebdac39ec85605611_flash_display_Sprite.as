package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6450b7e1d9667c75e44c7aebb992875db241437b34d563aebdac39ec85605611_flash_display_Sprite extends Sprite
   {
       
      
      public function _6450b7e1d9667c75e44c7aebb992875db241437b34d563aebdac39ec85605611_flash_display_Sprite()
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
