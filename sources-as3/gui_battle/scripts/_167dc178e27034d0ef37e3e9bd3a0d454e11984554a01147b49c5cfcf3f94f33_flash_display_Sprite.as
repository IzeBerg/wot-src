package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _167dc178e27034d0ef37e3e9bd3a0d454e11984554a01147b49c5cfcf3f94f33_flash_display_Sprite extends Sprite
   {
       
      
      public function _167dc178e27034d0ef37e3e9bd3a0d454e11984554a01147b49c5cfcf3f94f33_flash_display_Sprite()
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
