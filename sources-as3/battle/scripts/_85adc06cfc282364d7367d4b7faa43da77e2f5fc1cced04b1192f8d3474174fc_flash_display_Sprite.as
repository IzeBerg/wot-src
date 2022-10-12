package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _85adc06cfc282364d7367d4b7faa43da77e2f5fc1cced04b1192f8d3474174fc_flash_display_Sprite extends Sprite
   {
       
      
      public function _85adc06cfc282364d7367d4b7faa43da77e2f5fc1cced04b1192f8d3474174fc_flash_display_Sprite()
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
