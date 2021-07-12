package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1321137662a24a746d78f2b56149fcdd366bfc224d3950766a00e19fdbe31954_flash_display_Sprite extends Sprite
   {
       
      
      public function _1321137662a24a746d78f2b56149fcdd366bfc224d3950766a00e19fdbe31954_flash_display_Sprite()
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
