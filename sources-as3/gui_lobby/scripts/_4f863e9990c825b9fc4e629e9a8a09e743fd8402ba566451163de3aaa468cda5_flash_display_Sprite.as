package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4f863e9990c825b9fc4e629e9a8a09e743fd8402ba566451163de3aaa468cda5_flash_display_Sprite extends Sprite
   {
       
      
      public function _4f863e9990c825b9fc4e629e9a8a09e743fd8402ba566451163de3aaa468cda5_flash_display_Sprite()
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
