package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a45fd26fcae104b494520dc20a2953ed91ae5debb45e5c091f66ca96230de762_flash_display_Sprite extends Sprite
   {
       
      
      public function _a45fd26fcae104b494520dc20a2953ed91ae5debb45e5c091f66ca96230de762_flash_display_Sprite()
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
