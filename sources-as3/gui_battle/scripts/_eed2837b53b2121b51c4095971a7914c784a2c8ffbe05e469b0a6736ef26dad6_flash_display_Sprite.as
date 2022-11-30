package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _eed2837b53b2121b51c4095971a7914c784a2c8ffbe05e469b0a6736ef26dad6_flash_display_Sprite extends Sprite
   {
       
      
      public function _eed2837b53b2121b51c4095971a7914c784a2c8ffbe05e469b0a6736ef26dad6_flash_display_Sprite()
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
