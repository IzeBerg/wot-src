package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a243d0130b46e9740e0c2e9e1603fcb1dd923e721b8ce52f0813cc2a70fa6161_flash_display_Sprite extends Sprite
   {
       
      
      public function _a243d0130b46e9740e0c2e9e1603fcb1dd923e721b8ce52f0813cc2a70fa6161_flash_display_Sprite()
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
