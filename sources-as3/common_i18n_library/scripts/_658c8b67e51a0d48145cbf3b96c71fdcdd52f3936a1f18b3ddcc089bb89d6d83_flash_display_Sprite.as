package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _658c8b67e51a0d48145cbf3b96c71fdcdd52f3936a1f18b3ddcc089bb89d6d83_flash_display_Sprite extends Sprite
   {
       
      
      public function _658c8b67e51a0d48145cbf3b96c71fdcdd52f3936a1f18b3ddcc089bb89d6d83_flash_display_Sprite()
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
