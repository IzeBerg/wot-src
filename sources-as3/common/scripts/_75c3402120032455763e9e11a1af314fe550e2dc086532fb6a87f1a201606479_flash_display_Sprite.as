package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _75c3402120032455763e9e11a1af314fe550e2dc086532fb6a87f1a201606479_flash_display_Sprite extends Sprite
   {
       
      
      public function _75c3402120032455763e9e11a1af314fe550e2dc086532fb6a87f1a201606479_flash_display_Sprite()
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
