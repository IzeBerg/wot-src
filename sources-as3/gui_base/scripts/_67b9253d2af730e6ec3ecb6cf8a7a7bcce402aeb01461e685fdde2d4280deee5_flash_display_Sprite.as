package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _67b9253d2af730e6ec3ecb6cf8a7a7bcce402aeb01461e685fdde2d4280deee5_flash_display_Sprite extends Sprite
   {
       
      
      public function _67b9253d2af730e6ec3ecb6cf8a7a7bcce402aeb01461e685fdde2d4280deee5_flash_display_Sprite()
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
