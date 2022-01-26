package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c21eb44789fe3bbeb916876c014a99cb06039ae2629f96ac3a3ec231d613518f_flash_display_Sprite extends Sprite
   {
       
      
      public function _c21eb44789fe3bbeb916876c014a99cb06039ae2629f96ac3a3ec231d613518f_flash_display_Sprite()
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
