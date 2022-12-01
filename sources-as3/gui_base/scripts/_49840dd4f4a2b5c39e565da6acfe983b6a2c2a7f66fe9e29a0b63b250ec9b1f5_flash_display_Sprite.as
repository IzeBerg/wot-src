package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _49840dd4f4a2b5c39e565da6acfe983b6a2c2a7f66fe9e29a0b63b250ec9b1f5_flash_display_Sprite extends Sprite
   {
       
      
      public function _49840dd4f4a2b5c39e565da6acfe983b6a2c2a7f66fe9e29a0b63b250ec9b1f5_flash_display_Sprite()
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
