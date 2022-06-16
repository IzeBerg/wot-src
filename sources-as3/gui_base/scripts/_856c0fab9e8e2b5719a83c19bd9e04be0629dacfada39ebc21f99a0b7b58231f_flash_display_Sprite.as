package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _856c0fab9e8e2b5719a83c19bd9e04be0629dacfada39ebc21f99a0b7b58231f_flash_display_Sprite extends Sprite
   {
       
      
      public function _856c0fab9e8e2b5719a83c19bd9e04be0629dacfada39ebc21f99a0b7b58231f_flash_display_Sprite()
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
