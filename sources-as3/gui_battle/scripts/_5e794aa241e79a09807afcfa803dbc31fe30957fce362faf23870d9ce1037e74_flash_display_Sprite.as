package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5e794aa241e79a09807afcfa803dbc31fe30957fce362faf23870d9ce1037e74_flash_display_Sprite extends Sprite
   {
       
      
      public function _5e794aa241e79a09807afcfa803dbc31fe30957fce362faf23870d9ce1037e74_flash_display_Sprite()
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
