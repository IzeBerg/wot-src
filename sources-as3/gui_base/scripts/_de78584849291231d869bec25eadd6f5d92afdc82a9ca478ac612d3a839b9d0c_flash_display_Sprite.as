package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _de78584849291231d869bec25eadd6f5d92afdc82a9ca478ac612d3a839b9d0c_flash_display_Sprite extends Sprite
   {
       
      
      public function _de78584849291231d869bec25eadd6f5d92afdc82a9ca478ac612d3a839b9d0c_flash_display_Sprite()
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
