package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4f2885fe2e7a1002e192613b7c03495005ba6f3d5756a7e666bb56f5e83518e6_flash_display_Sprite extends Sprite
   {
       
      
      public function _4f2885fe2e7a1002e192613b7c03495005ba6f3d5756a7e666bb56f5e83518e6_flash_display_Sprite()
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
