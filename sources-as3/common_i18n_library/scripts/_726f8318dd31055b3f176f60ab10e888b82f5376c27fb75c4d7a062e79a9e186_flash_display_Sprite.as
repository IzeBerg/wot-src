package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _726f8318dd31055b3f176f60ab10e888b82f5376c27fb75c4d7a062e79a9e186_flash_display_Sprite extends Sprite
   {
       
      
      public function _726f8318dd31055b3f176f60ab10e888b82f5376c27fb75c4d7a062e79a9e186_flash_display_Sprite()
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
