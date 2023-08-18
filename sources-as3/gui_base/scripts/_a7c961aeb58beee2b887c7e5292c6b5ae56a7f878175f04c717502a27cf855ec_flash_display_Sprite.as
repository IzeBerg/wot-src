package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a7c961aeb58beee2b887c7e5292c6b5ae56a7f878175f04c717502a27cf855ec_flash_display_Sprite extends Sprite
   {
       
      
      public function _a7c961aeb58beee2b887c7e5292c6b5ae56a7f878175f04c717502a27cf855ec_flash_display_Sprite()
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
