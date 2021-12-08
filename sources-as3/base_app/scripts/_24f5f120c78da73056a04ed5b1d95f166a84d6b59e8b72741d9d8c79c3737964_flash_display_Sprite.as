package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _24f5f120c78da73056a04ed5b1d95f166a84d6b59e8b72741d9d8c79c3737964_flash_display_Sprite extends Sprite
   {
       
      
      public function _24f5f120c78da73056a04ed5b1d95f166a84d6b59e8b72741d9d8c79c3737964_flash_display_Sprite()
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
