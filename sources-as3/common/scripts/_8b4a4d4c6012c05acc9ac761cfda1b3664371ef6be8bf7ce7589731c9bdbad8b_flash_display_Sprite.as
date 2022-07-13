package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8b4a4d4c6012c05acc9ac761cfda1b3664371ef6be8bf7ce7589731c9bdbad8b_flash_display_Sprite extends Sprite
   {
       
      
      public function _8b4a4d4c6012c05acc9ac761cfda1b3664371ef6be8bf7ce7589731c9bdbad8b_flash_display_Sprite()
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
