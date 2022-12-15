package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d7dae06a8281a34b192411063901d780ae5bf3528eebca678e5f19fc1699c9b6_flash_display_Sprite extends Sprite
   {
       
      
      public function _d7dae06a8281a34b192411063901d780ae5bf3528eebca678e5f19fc1699c9b6_flash_display_Sprite()
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
