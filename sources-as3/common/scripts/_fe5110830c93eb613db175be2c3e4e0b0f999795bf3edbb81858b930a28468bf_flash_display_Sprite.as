package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fe5110830c93eb613db175be2c3e4e0b0f999795bf3edbb81858b930a28468bf_flash_display_Sprite extends Sprite
   {
       
      
      public function _fe5110830c93eb613db175be2c3e4e0b0f999795bf3edbb81858b930a28468bf_flash_display_Sprite()
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
