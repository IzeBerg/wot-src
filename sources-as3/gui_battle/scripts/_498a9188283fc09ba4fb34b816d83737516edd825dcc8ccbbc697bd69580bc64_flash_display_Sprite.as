package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _498a9188283fc09ba4fb34b816d83737516edd825dcc8ccbbc697bd69580bc64_flash_display_Sprite extends Sprite
   {
       
      
      public function _498a9188283fc09ba4fb34b816d83737516edd825dcc8ccbbc697bd69580bc64_flash_display_Sprite()
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
