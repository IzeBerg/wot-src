package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _520ff39b8f3f101429ced1c6114684b15653269de69be734ef5b22ed01dc3ae6_flash_display_Sprite extends Sprite
   {
       
      
      public function _520ff39b8f3f101429ced1c6114684b15653269de69be734ef5b22ed01dc3ae6_flash_display_Sprite()
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
