package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c5d5bce2be73f388961d92a380651e7782d68f3cc58c93c5e37134d1552e6906_flash_display_Sprite extends Sprite
   {
       
      
      public function _c5d5bce2be73f388961d92a380651e7782d68f3cc58c93c5e37134d1552e6906_flash_display_Sprite()
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
