package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _48bafe3d2ec0f63325ae91811098678e43445fe38c5b2cca878fcd080fa7c735_flash_display_Sprite extends Sprite
   {
       
      
      public function _48bafe3d2ec0f63325ae91811098678e43445fe38c5b2cca878fcd080fa7c735_flash_display_Sprite()
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
