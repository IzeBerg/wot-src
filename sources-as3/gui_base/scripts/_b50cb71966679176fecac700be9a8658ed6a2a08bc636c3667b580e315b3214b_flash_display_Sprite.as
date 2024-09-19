package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b50cb71966679176fecac700be9a8658ed6a2a08bc636c3667b580e315b3214b_flash_display_Sprite extends Sprite
   {
       
      
      public function _b50cb71966679176fecac700be9a8658ed6a2a08bc636c3667b580e315b3214b_flash_display_Sprite()
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
