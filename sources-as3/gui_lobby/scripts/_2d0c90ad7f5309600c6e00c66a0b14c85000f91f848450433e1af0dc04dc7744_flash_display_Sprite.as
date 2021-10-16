package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2d0c90ad7f5309600c6e00c66a0b14c85000f91f848450433e1af0dc04dc7744_flash_display_Sprite extends Sprite
   {
       
      
      public function _2d0c90ad7f5309600c6e00c66a0b14c85000f91f848450433e1af0dc04dc7744_flash_display_Sprite()
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
