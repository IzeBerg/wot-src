package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _eb59fd7d3779b0caddd6c0f01d3add36e6cda68b56634eccebec0c59c5ed75ee_flash_display_Sprite extends Sprite
   {
       
      
      public function _eb59fd7d3779b0caddd6c0f01d3add36e6cda68b56634eccebec0c59c5ed75ee_flash_display_Sprite()
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
