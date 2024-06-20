package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3fbb0f2a0a5dfe17f20a2d88f817657923b0c2ee76066ce20e2444efd2c53c24_flash_display_Sprite extends Sprite
   {
       
      
      public function _3fbb0f2a0a5dfe17f20a2d88f817657923b0c2ee76066ce20e2444efd2c53c24_flash_display_Sprite()
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
