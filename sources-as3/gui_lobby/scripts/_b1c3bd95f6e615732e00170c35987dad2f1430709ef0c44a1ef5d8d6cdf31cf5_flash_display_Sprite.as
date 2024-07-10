package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b1c3bd95f6e615732e00170c35987dad2f1430709ef0c44a1ef5d8d6cdf31cf5_flash_display_Sprite extends Sprite
   {
       
      
      public function _b1c3bd95f6e615732e00170c35987dad2f1430709ef0c44a1ef5d8d6cdf31cf5_flash_display_Sprite()
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
