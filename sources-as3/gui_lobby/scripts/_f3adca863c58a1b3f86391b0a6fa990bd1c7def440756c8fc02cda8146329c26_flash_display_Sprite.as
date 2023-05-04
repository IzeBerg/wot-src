package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f3adca863c58a1b3f86391b0a6fa990bd1c7def440756c8fc02cda8146329c26_flash_display_Sprite extends Sprite
   {
       
      
      public function _f3adca863c58a1b3f86391b0a6fa990bd1c7def440756c8fc02cda8146329c26_flash_display_Sprite()
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
