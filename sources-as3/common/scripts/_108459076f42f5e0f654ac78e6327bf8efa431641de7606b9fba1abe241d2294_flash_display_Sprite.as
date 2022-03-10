package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _108459076f42f5e0f654ac78e6327bf8efa431641de7606b9fba1abe241d2294_flash_display_Sprite extends Sprite
   {
       
      
      public function _108459076f42f5e0f654ac78e6327bf8efa431641de7606b9fba1abe241d2294_flash_display_Sprite()
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
