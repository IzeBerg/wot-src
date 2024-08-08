package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5887278a5dcc2a522e6bedbc23dbe4baff42ee33ae4b4e47803f9d79cf686451_flash_display_Sprite extends Sprite
   {
       
      
      public function _5887278a5dcc2a522e6bedbc23dbe4baff42ee33ae4b4e47803f9d79cf686451_flash_display_Sprite()
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
