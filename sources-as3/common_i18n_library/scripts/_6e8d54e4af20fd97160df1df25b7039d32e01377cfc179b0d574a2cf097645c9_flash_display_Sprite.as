package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6e8d54e4af20fd97160df1df25b7039d32e01377cfc179b0d574a2cf097645c9_flash_display_Sprite extends Sprite
   {
       
      
      public function _6e8d54e4af20fd97160df1df25b7039d32e01377cfc179b0d574a2cf097645c9_flash_display_Sprite()
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
