package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9e62fe316bedafb1008200c09ae009e2c395b6f552c06954a0e01fb8b909107b_flash_display_Sprite extends Sprite
   {
       
      
      public function _9e62fe316bedafb1008200c09ae009e2c395b6f552c06954a0e01fb8b909107b_flash_display_Sprite()
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
