package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _457aa41d6c5e800fc055eeb2ccb2b2d298d5fb18666a8ea3f60b900dcf22021d_flash_display_Sprite extends Sprite
   {
       
      
      public function _457aa41d6c5e800fc055eeb2ccb2b2d298d5fb18666a8ea3f60b900dcf22021d_flash_display_Sprite()
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
