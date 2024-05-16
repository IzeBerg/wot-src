package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3acb3b425e0e79cd4790b21bfc39824b71ff75fc1d6be044344cc64b7cf542fb_flash_display_Sprite extends Sprite
   {
       
      
      public function _3acb3b425e0e79cd4790b21bfc39824b71ff75fc1d6be044344cc64b7cf542fb_flash_display_Sprite()
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
