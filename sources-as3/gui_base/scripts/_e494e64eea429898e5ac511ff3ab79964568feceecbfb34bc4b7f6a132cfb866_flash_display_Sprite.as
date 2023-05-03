package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e494e64eea429898e5ac511ff3ab79964568feceecbfb34bc4b7f6a132cfb866_flash_display_Sprite extends Sprite
   {
       
      
      public function _e494e64eea429898e5ac511ff3ab79964568feceecbfb34bc4b7f6a132cfb866_flash_display_Sprite()
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
