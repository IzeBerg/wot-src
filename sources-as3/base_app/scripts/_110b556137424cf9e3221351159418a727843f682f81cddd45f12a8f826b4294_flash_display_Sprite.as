package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _110b556137424cf9e3221351159418a727843f682f81cddd45f12a8f826b4294_flash_display_Sprite extends Sprite
   {
       
      
      public function _110b556137424cf9e3221351159418a727843f682f81cddd45f12a8f826b4294_flash_display_Sprite()
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
