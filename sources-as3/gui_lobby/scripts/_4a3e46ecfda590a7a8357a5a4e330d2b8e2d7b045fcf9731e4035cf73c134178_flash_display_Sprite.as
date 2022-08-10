package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4a3e46ecfda590a7a8357a5a4e330d2b8e2d7b045fcf9731e4035cf73c134178_flash_display_Sprite extends Sprite
   {
       
      
      public function _4a3e46ecfda590a7a8357a5a4e330d2b8e2d7b045fcf9731e4035cf73c134178_flash_display_Sprite()
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
