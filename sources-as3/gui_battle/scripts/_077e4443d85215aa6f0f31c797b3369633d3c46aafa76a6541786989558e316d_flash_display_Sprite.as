package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _077e4443d85215aa6f0f31c797b3369633d3c46aafa76a6541786989558e316d_flash_display_Sprite extends Sprite
   {
       
      
      public function _077e4443d85215aa6f0f31c797b3369633d3c46aafa76a6541786989558e316d_flash_display_Sprite()
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
