package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a00cfb14cef8ed504fea1019468b0db2260a74fb2463adecdc18bac14cf25c13_flash_display_Sprite extends Sprite
   {
       
      
      public function _a00cfb14cef8ed504fea1019468b0db2260a74fb2463adecdc18bac14cf25c13_flash_display_Sprite()
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
