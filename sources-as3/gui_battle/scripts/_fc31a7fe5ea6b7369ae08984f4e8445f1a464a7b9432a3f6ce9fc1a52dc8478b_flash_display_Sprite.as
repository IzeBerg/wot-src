package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fc31a7fe5ea6b7369ae08984f4e8445f1a464a7b9432a3f6ce9fc1a52dc8478b_flash_display_Sprite extends Sprite
   {
       
      
      public function _fc31a7fe5ea6b7369ae08984f4e8445f1a464a7b9432a3f6ce9fc1a52dc8478b_flash_display_Sprite()
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
