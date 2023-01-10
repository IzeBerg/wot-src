package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _15cba2a60110f7af574aada84cfc35433fed64d2a827340665e628080fc0fff6_flash_display_Sprite extends Sprite
   {
       
      
      public function _15cba2a60110f7af574aada84cfc35433fed64d2a827340665e628080fc0fff6_flash_display_Sprite()
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
