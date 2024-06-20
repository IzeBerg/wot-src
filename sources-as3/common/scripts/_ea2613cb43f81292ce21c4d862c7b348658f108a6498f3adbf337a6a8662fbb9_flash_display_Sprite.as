package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ea2613cb43f81292ce21c4d862c7b348658f108a6498f3adbf337a6a8662fbb9_flash_display_Sprite extends Sprite
   {
       
      
      public function _ea2613cb43f81292ce21c4d862c7b348658f108a6498f3adbf337a6a8662fbb9_flash_display_Sprite()
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
