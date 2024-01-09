package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2bf10bdf2efdccddfd2e817fbe0cdafe9bf110597f0833b71a71f416b688fdc6_flash_display_Sprite extends Sprite
   {
       
      
      public function _2bf10bdf2efdccddfd2e817fbe0cdafe9bf110597f0833b71a71f416b688fdc6_flash_display_Sprite()
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
