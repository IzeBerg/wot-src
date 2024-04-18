package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5051d8b3e1743eb496dc398bf53269029c94a0222843070f285c4b595c8b908d_flash_display_Sprite extends Sprite
   {
       
      
      public function _5051d8b3e1743eb496dc398bf53269029c94a0222843070f285c4b595c8b908d_flash_display_Sprite()
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
