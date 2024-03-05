package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4bcb5a0337162aecba8e905f166faef300c0c57caa757104e84cd4e5ea79c7c8_flash_display_Sprite extends Sprite
   {
       
      
      public function _4bcb5a0337162aecba8e905f166faef300c0c57caa757104e84cd4e5ea79c7c8_flash_display_Sprite()
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
