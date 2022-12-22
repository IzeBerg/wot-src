package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3e9f8d71e9e9a95c1505510afb2ee197287a0c31e4c9c11f7bd93b819ca54bfa_flash_display_Sprite extends Sprite
   {
       
      
      public function _3e9f8d71e9e9a95c1505510afb2ee197287a0c31e4c9c11f7bd93b819ca54bfa_flash_display_Sprite()
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
