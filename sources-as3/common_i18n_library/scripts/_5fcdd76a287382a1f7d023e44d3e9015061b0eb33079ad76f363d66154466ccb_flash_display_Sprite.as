package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5fcdd76a287382a1f7d023e44d3e9015061b0eb33079ad76f363d66154466ccb_flash_display_Sprite extends Sprite
   {
       
      
      public function _5fcdd76a287382a1f7d023e44d3e9015061b0eb33079ad76f363d66154466ccb_flash_display_Sprite()
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
