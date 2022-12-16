package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a4d365281452343b219dab76332cbf9036c34311e5d3bf5851a645a913b27801_flash_display_Sprite extends Sprite
   {
       
      
      public function _a4d365281452343b219dab76332cbf9036c34311e5d3bf5851a645a913b27801_flash_display_Sprite()
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
