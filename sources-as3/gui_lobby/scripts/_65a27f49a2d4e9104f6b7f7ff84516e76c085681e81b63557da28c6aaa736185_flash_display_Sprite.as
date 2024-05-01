package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _65a27f49a2d4e9104f6b7f7ff84516e76c085681e81b63557da28c6aaa736185_flash_display_Sprite extends Sprite
   {
       
      
      public function _65a27f49a2d4e9104f6b7f7ff84516e76c085681e81b63557da28c6aaa736185_flash_display_Sprite()
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
