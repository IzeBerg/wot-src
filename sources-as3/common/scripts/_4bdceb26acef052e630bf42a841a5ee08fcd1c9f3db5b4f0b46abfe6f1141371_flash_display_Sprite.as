package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4bdceb26acef052e630bf42a841a5ee08fcd1c9f3db5b4f0b46abfe6f1141371_flash_display_Sprite extends Sprite
   {
       
      
      public function _4bdceb26acef052e630bf42a841a5ee08fcd1c9f3db5b4f0b46abfe6f1141371_flash_display_Sprite()
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
