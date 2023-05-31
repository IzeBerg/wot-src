package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _32b3fb38e38651a6614dae2ad2c166bdf7278ca48584c6b0fac270d81770948c_flash_display_Sprite extends Sprite
   {
       
      
      public function _32b3fb38e38651a6614dae2ad2c166bdf7278ca48584c6b0fac270d81770948c_flash_display_Sprite()
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
