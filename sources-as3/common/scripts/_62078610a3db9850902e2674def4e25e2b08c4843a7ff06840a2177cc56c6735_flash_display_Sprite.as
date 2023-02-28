package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _62078610a3db9850902e2674def4e25e2b08c4843a7ff06840a2177cc56c6735_flash_display_Sprite extends Sprite
   {
       
      
      public function _62078610a3db9850902e2674def4e25e2b08c4843a7ff06840a2177cc56c6735_flash_display_Sprite()
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
