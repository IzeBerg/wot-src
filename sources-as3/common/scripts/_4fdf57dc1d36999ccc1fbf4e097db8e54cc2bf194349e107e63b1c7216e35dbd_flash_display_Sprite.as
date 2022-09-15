package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4fdf57dc1d36999ccc1fbf4e097db8e54cc2bf194349e107e63b1c7216e35dbd_flash_display_Sprite extends Sprite
   {
       
      
      public function _4fdf57dc1d36999ccc1fbf4e097db8e54cc2bf194349e107e63b1c7216e35dbd_flash_display_Sprite()
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
