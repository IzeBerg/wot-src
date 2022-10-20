package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4834fbb6b098874320032b00f06e4328ffecafdb5b7d46705a0991b97335cc25_flash_display_Sprite extends Sprite
   {
       
      
      public function _4834fbb6b098874320032b00f06e4328ffecafdb5b7d46705a0991b97335cc25_flash_display_Sprite()
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
