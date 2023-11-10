package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _256ef9aa6de4bf748326279566284d9e5c8588e20a2d3eec049451f1efb58268_flash_display_Sprite extends Sprite
   {
       
      
      public function _256ef9aa6de4bf748326279566284d9e5c8588e20a2d3eec049451f1efb58268_flash_display_Sprite()
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
