package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f50bc1925468f9076526a30a148f336e9ea83d563769d5a7eb6f304b97189195_flash_display_Sprite extends Sprite
   {
       
      
      public function _f50bc1925468f9076526a30a148f336e9ea83d563769d5a7eb6f304b97189195_flash_display_Sprite()
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
