package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b2a8f800c938ae6eeac68d75dbba7e613a9403045cbde50623e830aaeaf1ec47_flash_display_Sprite extends Sprite
   {
       
      
      public function _b2a8f800c938ae6eeac68d75dbba7e613a9403045cbde50623e830aaeaf1ec47_flash_display_Sprite()
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
