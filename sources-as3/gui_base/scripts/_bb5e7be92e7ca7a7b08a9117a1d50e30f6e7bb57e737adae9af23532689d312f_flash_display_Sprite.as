package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bb5e7be92e7ca7a7b08a9117a1d50e30f6e7bb57e737adae9af23532689d312f_flash_display_Sprite extends Sprite
   {
       
      
      public function _bb5e7be92e7ca7a7b08a9117a1d50e30f6e7bb57e737adae9af23532689d312f_flash_display_Sprite()
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
