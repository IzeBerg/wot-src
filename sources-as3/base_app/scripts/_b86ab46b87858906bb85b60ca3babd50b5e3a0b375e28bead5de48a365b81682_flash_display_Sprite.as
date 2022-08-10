package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b86ab46b87858906bb85b60ca3babd50b5e3a0b375e28bead5de48a365b81682_flash_display_Sprite extends Sprite
   {
       
      
      public function _b86ab46b87858906bb85b60ca3babd50b5e3a0b375e28bead5de48a365b81682_flash_display_Sprite()
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
