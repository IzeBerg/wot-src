package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0d3b144870c3174f48bb3623b4bb0d945c2f680b7161db8e91d3b01e9df7aa2a_flash_display_Sprite extends Sprite
   {
       
      
      public function _0d3b144870c3174f48bb3623b4bb0d945c2f680b7161db8e91d3b01e9df7aa2a_flash_display_Sprite()
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
