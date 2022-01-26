package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1c35d5d7768ddc1964f0b7a135fff52174c0892b4583b24085831ff56c29f21e_flash_display_Sprite extends Sprite
   {
       
      
      public function _1c35d5d7768ddc1964f0b7a135fff52174c0892b4583b24085831ff56c29f21e_flash_display_Sprite()
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
