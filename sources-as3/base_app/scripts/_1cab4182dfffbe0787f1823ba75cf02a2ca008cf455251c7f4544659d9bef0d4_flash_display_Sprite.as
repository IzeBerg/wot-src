package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1cab4182dfffbe0787f1823ba75cf02a2ca008cf455251c7f4544659d9bef0d4_flash_display_Sprite extends Sprite
   {
       
      
      public function _1cab4182dfffbe0787f1823ba75cf02a2ca008cf455251c7f4544659d9bef0d4_flash_display_Sprite()
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
