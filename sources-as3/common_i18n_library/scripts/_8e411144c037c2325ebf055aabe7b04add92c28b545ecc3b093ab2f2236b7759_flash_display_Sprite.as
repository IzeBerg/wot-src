package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8e411144c037c2325ebf055aabe7b04add92c28b545ecc3b093ab2f2236b7759_flash_display_Sprite extends Sprite
   {
       
      
      public function _8e411144c037c2325ebf055aabe7b04add92c28b545ecc3b093ab2f2236b7759_flash_display_Sprite()
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
