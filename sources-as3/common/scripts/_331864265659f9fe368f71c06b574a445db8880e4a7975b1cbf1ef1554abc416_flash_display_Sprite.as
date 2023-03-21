package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _331864265659f9fe368f71c06b574a445db8880e4a7975b1cbf1ef1554abc416_flash_display_Sprite extends Sprite
   {
       
      
      public function _331864265659f9fe368f71c06b574a445db8880e4a7975b1cbf1ef1554abc416_flash_display_Sprite()
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
