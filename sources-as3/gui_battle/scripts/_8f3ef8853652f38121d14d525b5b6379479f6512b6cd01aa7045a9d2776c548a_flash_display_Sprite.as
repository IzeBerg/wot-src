package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8f3ef8853652f38121d14d525b5b6379479f6512b6cd01aa7045a9d2776c548a_flash_display_Sprite extends Sprite
   {
       
      
      public function _8f3ef8853652f38121d14d525b5b6379479f6512b6cd01aa7045a9d2776c548a_flash_display_Sprite()
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
