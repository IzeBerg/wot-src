package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _841aeb2c0f1a6ff824a513cd890f317b480ea5b19d5475557a96d5449753d756_flash_display_Sprite extends Sprite
   {
       
      
      public function _841aeb2c0f1a6ff824a513cd890f317b480ea5b19d5475557a96d5449753d756_flash_display_Sprite()
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
