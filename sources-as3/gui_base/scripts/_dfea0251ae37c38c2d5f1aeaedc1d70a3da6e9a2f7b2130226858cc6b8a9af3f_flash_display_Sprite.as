package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dfea0251ae37c38c2d5f1aeaedc1d70a3da6e9a2f7b2130226858cc6b8a9af3f_flash_display_Sprite extends Sprite
   {
       
      
      public function _dfea0251ae37c38c2d5f1aeaedc1d70a3da6e9a2f7b2130226858cc6b8a9af3f_flash_display_Sprite()
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
