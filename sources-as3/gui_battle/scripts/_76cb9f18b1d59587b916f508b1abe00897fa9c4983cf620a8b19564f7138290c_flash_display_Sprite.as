package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _76cb9f18b1d59587b916f508b1abe00897fa9c4983cf620a8b19564f7138290c_flash_display_Sprite extends Sprite
   {
       
      
      public function _76cb9f18b1d59587b916f508b1abe00897fa9c4983cf620a8b19564f7138290c_flash_display_Sprite()
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
