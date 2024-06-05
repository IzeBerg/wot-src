package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4cf1883824a788f53fb9718999f6a5154a900d8e10519cc11983d20dbc97e677_flash_display_Sprite extends Sprite
   {
       
      
      public function _4cf1883824a788f53fb9718999f6a5154a900d8e10519cc11983d20dbc97e677_flash_display_Sprite()
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
