package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a00d8bc326bc0060bea28014a4fd4d101d834bc36a6d4f5732d8dfbb36b1c52a_flash_display_Sprite extends Sprite
   {
       
      
      public function _a00d8bc326bc0060bea28014a4fd4d101d834bc36a6d4f5732d8dfbb36b1c52a_flash_display_Sprite()
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
