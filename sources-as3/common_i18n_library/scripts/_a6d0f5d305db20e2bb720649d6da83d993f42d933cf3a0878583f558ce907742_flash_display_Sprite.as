package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a6d0f5d305db20e2bb720649d6da83d993f42d933cf3a0878583f558ce907742_flash_display_Sprite extends Sprite
   {
       
      
      public function _a6d0f5d305db20e2bb720649d6da83d993f42d933cf3a0878583f558ce907742_flash_display_Sprite()
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
