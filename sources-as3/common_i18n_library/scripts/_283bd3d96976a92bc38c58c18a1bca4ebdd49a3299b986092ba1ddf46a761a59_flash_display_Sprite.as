package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _283bd3d96976a92bc38c58c18a1bca4ebdd49a3299b986092ba1ddf46a761a59_flash_display_Sprite extends Sprite
   {
       
      
      public function _283bd3d96976a92bc38c58c18a1bca4ebdd49a3299b986092ba1ddf46a761a59_flash_display_Sprite()
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
