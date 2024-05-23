package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9c30c876676ba51c1bf542c7c0b0a48b033963e1d212a41efa289b3f00c5cb3b_flash_display_Sprite extends Sprite
   {
       
      
      public function _9c30c876676ba51c1bf542c7c0b0a48b033963e1d212a41efa289b3f00c5cb3b_flash_display_Sprite()
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
