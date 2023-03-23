package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _486f29130eb5ada3052f174aa984dcdfa8be898bc63b78b32921d5072abeea12_flash_display_Sprite extends Sprite
   {
       
      
      public function _486f29130eb5ada3052f174aa984dcdfa8be898bc63b78b32921d5072abeea12_flash_display_Sprite()
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
