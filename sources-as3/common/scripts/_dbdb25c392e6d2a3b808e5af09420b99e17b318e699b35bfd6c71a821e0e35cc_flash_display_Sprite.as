package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dbdb25c392e6d2a3b808e5af09420b99e17b318e699b35bfd6c71a821e0e35cc_flash_display_Sprite extends Sprite
   {
       
      
      public function _dbdb25c392e6d2a3b808e5af09420b99e17b318e699b35bfd6c71a821e0e35cc_flash_display_Sprite()
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
