package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dc3030d4dfac62cec6217c63476729d66a65084f16e49fd78ed3878d7ff8df67_flash_display_Sprite extends Sprite
   {
       
      
      public function _dc3030d4dfac62cec6217c63476729d66a65084f16e49fd78ed3878d7ff8df67_flash_display_Sprite()
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
