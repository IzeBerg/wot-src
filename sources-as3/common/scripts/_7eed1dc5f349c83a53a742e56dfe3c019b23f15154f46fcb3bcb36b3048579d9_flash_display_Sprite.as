package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7eed1dc5f349c83a53a742e56dfe3c019b23f15154f46fcb3bcb36b3048579d9_flash_display_Sprite extends Sprite
   {
       
      
      public function _7eed1dc5f349c83a53a742e56dfe3c019b23f15154f46fcb3bcb36b3048579d9_flash_display_Sprite()
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
