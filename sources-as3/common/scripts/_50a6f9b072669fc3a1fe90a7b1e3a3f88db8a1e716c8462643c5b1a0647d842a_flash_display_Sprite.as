package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _50a6f9b072669fc3a1fe90a7b1e3a3f88db8a1e716c8462643c5b1a0647d842a_flash_display_Sprite extends Sprite
   {
       
      
      public function _50a6f9b072669fc3a1fe90a7b1e3a3f88db8a1e716c8462643c5b1a0647d842a_flash_display_Sprite()
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
