package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e34c40b197af0935ac194dba0552661e27a347899832448d40b442eadb5d43c9_flash_display_Sprite extends Sprite
   {
       
      
      public function _e34c40b197af0935ac194dba0552661e27a347899832448d40b442eadb5d43c9_flash_display_Sprite()
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
