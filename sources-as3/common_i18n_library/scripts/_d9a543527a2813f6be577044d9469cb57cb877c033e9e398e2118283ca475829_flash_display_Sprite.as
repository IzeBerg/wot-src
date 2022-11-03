package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d9a543527a2813f6be577044d9469cb57cb877c033e9e398e2118283ca475829_flash_display_Sprite extends Sprite
   {
       
      
      public function _d9a543527a2813f6be577044d9469cb57cb877c033e9e398e2118283ca475829_flash_display_Sprite()
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
