package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9597c3a6f3d54c8d40bf58a746d21a191ac0463f3768f2a326d87af69dfa57ce_flash_display_Sprite extends Sprite
   {
       
      
      public function _9597c3a6f3d54c8d40bf58a746d21a191ac0463f3768f2a326d87af69dfa57ce_flash_display_Sprite()
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
