package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f2965ff5539adcadd4a738a1ac883ec0bce6bbaa81fe4b04cb3573b9f33470fd_flash_display_Sprite extends Sprite
   {
       
      
      public function _f2965ff5539adcadd4a738a1ac883ec0bce6bbaa81fe4b04cb3573b9f33470fd_flash_display_Sprite()
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
