package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d2a2a15177bc68d9039f15f7478d729c06dcc4e6e5075aca78fe8dd175c89d14_flash_display_Sprite extends Sprite
   {
       
      
      public function _d2a2a15177bc68d9039f15f7478d729c06dcc4e6e5075aca78fe8dd175c89d14_flash_display_Sprite()
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
