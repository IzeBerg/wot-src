package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _08b4610223b54ae659209b9bf5ed6e3bb21212a2d946700f6be19d8840496e75_flash_display_Sprite extends Sprite
   {
       
      
      public function _08b4610223b54ae659209b9bf5ed6e3bb21212a2d946700f6be19d8840496e75_flash_display_Sprite()
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
