package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8facabea1c28ac915376e56f3aaa6a129ecf5c4b0565664233b5b3033bca2dfa_flash_display_Sprite extends Sprite
   {
       
      
      public function _8facabea1c28ac915376e56f3aaa6a129ecf5c4b0565664233b5b3033bca2dfa_flash_display_Sprite()
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
