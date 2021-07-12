package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3a265e1c7f8395bb04c77c8d6d716063059c188bd6d11f7891b4e5f133d9fff5_flash_display_Sprite extends Sprite
   {
       
      
      public function _3a265e1c7f8395bb04c77c8d6d716063059c188bd6d11f7891b4e5f133d9fff5_flash_display_Sprite()
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
