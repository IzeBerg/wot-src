package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5ccd1a6792ec8a444cd4f7b8d47ee374f119a28372a9115d2006b4151c109259_flash_display_Sprite extends Sprite
   {
       
      
      public function _5ccd1a6792ec8a444cd4f7b8d47ee374f119a28372a9115d2006b4151c109259_flash_display_Sprite()
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
