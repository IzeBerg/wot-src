package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4362f0305f63630b5383658d074bcc91f5bff8d726bbded246f5b4db41bffb69_flash_display_Sprite extends Sprite
   {
       
      
      public function _4362f0305f63630b5383658d074bcc91f5bff8d726bbded246f5b4db41bffb69_flash_display_Sprite()
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
