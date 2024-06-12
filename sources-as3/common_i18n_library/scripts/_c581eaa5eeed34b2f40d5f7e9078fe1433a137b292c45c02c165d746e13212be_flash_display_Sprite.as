package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c581eaa5eeed34b2f40d5f7e9078fe1433a137b292c45c02c165d746e13212be_flash_display_Sprite extends Sprite
   {
       
      
      public function _c581eaa5eeed34b2f40d5f7e9078fe1433a137b292c45c02c165d746e13212be_flash_display_Sprite()
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
