package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9f099eec3bbab89f55b26e93e4160be32ca31055472c467ae5698fccd26e4c65_flash_display_Sprite extends Sprite
   {
       
      
      public function _9f099eec3bbab89f55b26e93e4160be32ca31055472c467ae5698fccd26e4c65_flash_display_Sprite()
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
