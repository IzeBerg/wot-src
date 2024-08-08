package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _676d8212013d3994e61f4883c41f3345fe70b3675ee4f97080a84d7dfaba4efe_flash_display_Sprite extends Sprite
   {
       
      
      public function _676d8212013d3994e61f4883c41f3345fe70b3675ee4f97080a84d7dfaba4efe_flash_display_Sprite()
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
