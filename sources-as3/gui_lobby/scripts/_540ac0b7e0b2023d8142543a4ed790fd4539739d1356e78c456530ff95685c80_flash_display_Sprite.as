package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _540ac0b7e0b2023d8142543a4ed790fd4539739d1356e78c456530ff95685c80_flash_display_Sprite extends Sprite
   {
       
      
      public function _540ac0b7e0b2023d8142543a4ed790fd4539739d1356e78c456530ff95685c80_flash_display_Sprite()
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
