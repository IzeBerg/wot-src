package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _de76371cde2a71a3b404b6885c9a285a5e5630bcce0982becae5cac36d6c41f9_flash_display_Sprite extends Sprite
   {
       
      
      public function _de76371cde2a71a3b404b6885c9a285a5e5630bcce0982becae5cac36d6c41f9_flash_display_Sprite()
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
