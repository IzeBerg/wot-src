package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6e176b7a97f86d7c2154ea3a694d03ee63c97fd58abed1aa3683865296dfaa6b_flash_display_Sprite extends Sprite
   {
       
      
      public function _6e176b7a97f86d7c2154ea3a694d03ee63c97fd58abed1aa3683865296dfaa6b_flash_display_Sprite()
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
