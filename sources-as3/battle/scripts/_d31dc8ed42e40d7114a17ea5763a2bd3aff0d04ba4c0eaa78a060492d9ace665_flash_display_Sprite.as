package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d31dc8ed42e40d7114a17ea5763a2bd3aff0d04ba4c0eaa78a060492d9ace665_flash_display_Sprite extends Sprite
   {
       
      
      public function _d31dc8ed42e40d7114a17ea5763a2bd3aff0d04ba4c0eaa78a060492d9ace665_flash_display_Sprite()
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
