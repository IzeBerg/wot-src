package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8eba51c7c7f6bfd2b3c5092ea3227d995a9c8371874e89bf04109a06ad7513b5_flash_display_Sprite extends Sprite
   {
       
      
      public function _8eba51c7c7f6bfd2b3c5092ea3227d995a9c8371874e89bf04109a06ad7513b5_flash_display_Sprite()
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
