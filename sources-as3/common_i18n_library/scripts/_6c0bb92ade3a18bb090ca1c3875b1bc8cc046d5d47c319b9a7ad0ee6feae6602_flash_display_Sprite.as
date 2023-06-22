package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6c0bb92ade3a18bb090ca1c3875b1bc8cc046d5d47c319b9a7ad0ee6feae6602_flash_display_Sprite extends Sprite
   {
       
      
      public function _6c0bb92ade3a18bb090ca1c3875b1bc8cc046d5d47c319b9a7ad0ee6feae6602_flash_display_Sprite()
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
