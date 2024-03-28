package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a8253fb2c01113a4bdda70dabbcdc7659fcee40fd1c6b6c3efea0bb6d891f26a_flash_display_Sprite extends Sprite
   {
       
      
      public function _a8253fb2c01113a4bdda70dabbcdc7659fcee40fd1c6b6c3efea0bb6d891f26a_flash_display_Sprite()
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
