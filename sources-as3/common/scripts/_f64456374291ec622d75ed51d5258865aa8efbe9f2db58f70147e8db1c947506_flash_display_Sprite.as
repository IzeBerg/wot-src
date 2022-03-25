package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f64456374291ec622d75ed51d5258865aa8efbe9f2db58f70147e8db1c947506_flash_display_Sprite extends Sprite
   {
       
      
      public function _f64456374291ec622d75ed51d5258865aa8efbe9f2db58f70147e8db1c947506_flash_display_Sprite()
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
