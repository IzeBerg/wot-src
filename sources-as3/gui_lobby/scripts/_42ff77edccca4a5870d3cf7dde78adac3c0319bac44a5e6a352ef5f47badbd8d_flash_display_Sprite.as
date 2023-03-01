package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _42ff77edccca4a5870d3cf7dde78adac3c0319bac44a5e6a352ef5f47badbd8d_flash_display_Sprite extends Sprite
   {
       
      
      public function _42ff77edccca4a5870d3cf7dde78adac3c0319bac44a5e6a352ef5f47badbd8d_flash_display_Sprite()
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
