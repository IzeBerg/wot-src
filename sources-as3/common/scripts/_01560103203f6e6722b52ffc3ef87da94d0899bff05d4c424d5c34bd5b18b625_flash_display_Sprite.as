package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _01560103203f6e6722b52ffc3ef87da94d0899bff05d4c424d5c34bd5b18b625_flash_display_Sprite extends Sprite
   {
       
      
      public function _01560103203f6e6722b52ffc3ef87da94d0899bff05d4c424d5c34bd5b18b625_flash_display_Sprite()
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
