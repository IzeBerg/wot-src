package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0dd55831c0acacfdec4f41d546b5d5e2d4b615bab653cd9604afa32f83e453b1_flash_display_Sprite extends Sprite
   {
       
      
      public function _0dd55831c0acacfdec4f41d546b5d5e2d4b615bab653cd9604afa32f83e453b1_flash_display_Sprite()
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
