package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2041f190939ac841cd71dadd816a3d53035cd8124787ead370e42c8745f5737b_flash_display_Sprite extends Sprite
   {
       
      
      public function _2041f190939ac841cd71dadd816a3d53035cd8124787ead370e42c8745f5737b_flash_display_Sprite()
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
