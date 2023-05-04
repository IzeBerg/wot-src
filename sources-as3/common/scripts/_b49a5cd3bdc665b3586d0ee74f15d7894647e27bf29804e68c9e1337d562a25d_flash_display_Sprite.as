package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b49a5cd3bdc665b3586d0ee74f15d7894647e27bf29804e68c9e1337d562a25d_flash_display_Sprite extends Sprite
   {
       
      
      public function _b49a5cd3bdc665b3586d0ee74f15d7894647e27bf29804e68c9e1337d562a25d_flash_display_Sprite()
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
