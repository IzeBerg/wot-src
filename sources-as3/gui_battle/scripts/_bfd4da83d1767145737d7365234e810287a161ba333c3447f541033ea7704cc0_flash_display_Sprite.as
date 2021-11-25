package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bfd4da83d1767145737d7365234e810287a161ba333c3447f541033ea7704cc0_flash_display_Sprite extends Sprite
   {
       
      
      public function _bfd4da83d1767145737d7365234e810287a161ba333c3447f541033ea7704cc0_flash_display_Sprite()
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
