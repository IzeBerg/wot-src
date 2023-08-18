package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _45207ce460618845a6771c2dd83f7fd63715f0696fb2d586c25af6c61cb2d1f5_flash_display_Sprite extends Sprite
   {
       
      
      public function _45207ce460618845a6771c2dd83f7fd63715f0696fb2d586c25af6c61cb2d1f5_flash_display_Sprite()
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
