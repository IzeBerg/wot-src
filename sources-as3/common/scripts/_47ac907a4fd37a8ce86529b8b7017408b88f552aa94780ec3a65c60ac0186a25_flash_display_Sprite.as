package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _47ac907a4fd37a8ce86529b8b7017408b88f552aa94780ec3a65c60ac0186a25_flash_display_Sprite extends Sprite
   {
       
      
      public function _47ac907a4fd37a8ce86529b8b7017408b88f552aa94780ec3a65c60ac0186a25_flash_display_Sprite()
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
