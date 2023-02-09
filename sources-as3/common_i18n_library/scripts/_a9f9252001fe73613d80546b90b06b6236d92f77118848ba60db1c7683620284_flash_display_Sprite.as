package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a9f9252001fe73613d80546b90b06b6236d92f77118848ba60db1c7683620284_flash_display_Sprite extends Sprite
   {
       
      
      public function _a9f9252001fe73613d80546b90b06b6236d92f77118848ba60db1c7683620284_flash_display_Sprite()
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
