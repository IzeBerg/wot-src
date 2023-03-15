package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b57a5d10299f2a7bf06356c842084663ef205b38e800364cb0938b30099b1e17_flash_display_Sprite extends Sprite
   {
       
      
      public function _b57a5d10299f2a7bf06356c842084663ef205b38e800364cb0938b30099b1e17_flash_display_Sprite()
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
