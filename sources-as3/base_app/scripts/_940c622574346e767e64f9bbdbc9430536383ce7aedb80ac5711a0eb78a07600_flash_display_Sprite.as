package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _940c622574346e767e64f9bbdbc9430536383ce7aedb80ac5711a0eb78a07600_flash_display_Sprite extends Sprite
   {
       
      
      public function _940c622574346e767e64f9bbdbc9430536383ce7aedb80ac5711a0eb78a07600_flash_display_Sprite()
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
