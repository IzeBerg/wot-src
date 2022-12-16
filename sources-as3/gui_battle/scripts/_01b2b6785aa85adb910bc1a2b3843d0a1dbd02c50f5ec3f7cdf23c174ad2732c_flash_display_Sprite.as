package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _01b2b6785aa85adb910bc1a2b3843d0a1dbd02c50f5ec3f7cdf23c174ad2732c_flash_display_Sprite extends Sprite
   {
       
      
      public function _01b2b6785aa85adb910bc1a2b3843d0a1dbd02c50f5ec3f7cdf23c174ad2732c_flash_display_Sprite()
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
