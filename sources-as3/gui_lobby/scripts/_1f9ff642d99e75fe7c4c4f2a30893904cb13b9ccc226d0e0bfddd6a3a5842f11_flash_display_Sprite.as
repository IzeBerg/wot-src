package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1f9ff642d99e75fe7c4c4f2a30893904cb13b9ccc226d0e0bfddd6a3a5842f11_flash_display_Sprite extends Sprite
   {
       
      
      public function _1f9ff642d99e75fe7c4c4f2a30893904cb13b9ccc226d0e0bfddd6a3a5842f11_flash_display_Sprite()
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
