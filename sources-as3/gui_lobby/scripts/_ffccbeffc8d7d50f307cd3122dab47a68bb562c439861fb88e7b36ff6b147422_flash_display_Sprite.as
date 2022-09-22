package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ffccbeffc8d7d50f307cd3122dab47a68bb562c439861fb88e7b36ff6b147422_flash_display_Sprite extends Sprite
   {
       
      
      public function _ffccbeffc8d7d50f307cd3122dab47a68bb562c439861fb88e7b36ff6b147422_flash_display_Sprite()
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
