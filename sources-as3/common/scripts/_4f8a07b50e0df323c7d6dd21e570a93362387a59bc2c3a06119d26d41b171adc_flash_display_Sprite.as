package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4f8a07b50e0df323c7d6dd21e570a93362387a59bc2c3a06119d26d41b171adc_flash_display_Sprite extends Sprite
   {
       
      
      public function _4f8a07b50e0df323c7d6dd21e570a93362387a59bc2c3a06119d26d41b171adc_flash_display_Sprite()
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
