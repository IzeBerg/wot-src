package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _db24ef69833d1d43cf30bbc915b03272b71b3506583c12ffa56d937eaa3810fc_flash_display_Sprite extends Sprite
   {
       
      
      public function _db24ef69833d1d43cf30bbc915b03272b71b3506583c12ffa56d937eaa3810fc_flash_display_Sprite()
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
