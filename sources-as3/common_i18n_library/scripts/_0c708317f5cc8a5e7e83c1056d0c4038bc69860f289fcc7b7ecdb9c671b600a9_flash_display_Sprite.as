package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0c708317f5cc8a5e7e83c1056d0c4038bc69860f289fcc7b7ecdb9c671b600a9_flash_display_Sprite extends Sprite
   {
       
      
      public function _0c708317f5cc8a5e7e83c1056d0c4038bc69860f289fcc7b7ecdb9c671b600a9_flash_display_Sprite()
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
