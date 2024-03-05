package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _869aaad514318096178827c7ca07559389406f6640e1a2232db82757b55a12bf_flash_display_Sprite extends Sprite
   {
       
      
      public function _869aaad514318096178827c7ca07559389406f6640e1a2232db82757b55a12bf_flash_display_Sprite()
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
