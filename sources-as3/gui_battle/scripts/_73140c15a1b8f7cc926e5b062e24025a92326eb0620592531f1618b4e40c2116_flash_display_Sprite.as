package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _73140c15a1b8f7cc926e5b062e24025a92326eb0620592531f1618b4e40c2116_flash_display_Sprite extends Sprite
   {
       
      
      public function _73140c15a1b8f7cc926e5b062e24025a92326eb0620592531f1618b4e40c2116_flash_display_Sprite()
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
