package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _57acc114022a5b7b21ceaece9e54b0d0097891d7fa737cc0edf428a0f1caf3fc_flash_display_Sprite extends Sprite
   {
       
      
      public function _57acc114022a5b7b21ceaece9e54b0d0097891d7fa737cc0edf428a0f1caf3fc_flash_display_Sprite()
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
