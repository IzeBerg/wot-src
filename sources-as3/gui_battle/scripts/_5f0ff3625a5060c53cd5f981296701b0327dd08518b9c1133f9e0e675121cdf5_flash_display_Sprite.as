package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5f0ff3625a5060c53cd5f981296701b0327dd08518b9c1133f9e0e675121cdf5_flash_display_Sprite extends Sprite
   {
       
      
      public function _5f0ff3625a5060c53cd5f981296701b0327dd08518b9c1133f9e0e675121cdf5_flash_display_Sprite()
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
