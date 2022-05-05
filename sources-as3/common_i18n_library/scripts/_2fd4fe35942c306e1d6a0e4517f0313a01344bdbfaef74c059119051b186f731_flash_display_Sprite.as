package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2fd4fe35942c306e1d6a0e4517f0313a01344bdbfaef74c059119051b186f731_flash_display_Sprite extends Sprite
   {
       
      
      public function _2fd4fe35942c306e1d6a0e4517f0313a01344bdbfaef74c059119051b186f731_flash_display_Sprite()
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
