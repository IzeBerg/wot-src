package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7dd88c14537ae9315f7c747703f141c4b8e29b4a3a228323b2311c71b750cccd_flash_display_Sprite extends Sprite
   {
       
      
      public function _7dd88c14537ae9315f7c747703f141c4b8e29b4a3a228323b2311c71b750cccd_flash_display_Sprite()
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
