package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _693b88804e3ad11b26a5dc890c669916a3d55875da750f86becfbb91085a6e07_flash_display_Sprite extends Sprite
   {
       
      
      public function _693b88804e3ad11b26a5dc890c669916a3d55875da750f86becfbb91085a6e07_flash_display_Sprite()
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
