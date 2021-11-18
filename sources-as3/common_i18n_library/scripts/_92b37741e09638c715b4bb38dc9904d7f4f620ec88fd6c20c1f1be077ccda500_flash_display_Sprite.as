package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _92b37741e09638c715b4bb38dc9904d7f4f620ec88fd6c20c1f1be077ccda500_flash_display_Sprite extends Sprite
   {
       
      
      public function _92b37741e09638c715b4bb38dc9904d7f4f620ec88fd6c20c1f1be077ccda500_flash_display_Sprite()
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
