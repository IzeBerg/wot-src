package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4acfe6f338bc2069903ae8039b4b9c0ac70bab3373fadb3026e9983619f55627_flash_display_Sprite extends Sprite
   {
       
      
      public function _4acfe6f338bc2069903ae8039b4b9c0ac70bab3373fadb3026e9983619f55627_flash_display_Sprite()
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
