package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0509a38614df1dd221478a2dec7d31bf731f83a75cdd27621adea80672570e1d_flash_display_Sprite extends Sprite
   {
       
      
      public function _0509a38614df1dd221478a2dec7d31bf731f83a75cdd27621adea80672570e1d_flash_display_Sprite()
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
