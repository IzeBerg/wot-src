package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f7e0b2100e457affa11b6da044cf593a3ae1dd5cc8adad2fb7354b11e4acdbed_flash_display_Sprite extends Sprite
   {
       
      
      public function _f7e0b2100e457affa11b6da044cf593a3ae1dd5cc8adad2fb7354b11e4acdbed_flash_display_Sprite()
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
