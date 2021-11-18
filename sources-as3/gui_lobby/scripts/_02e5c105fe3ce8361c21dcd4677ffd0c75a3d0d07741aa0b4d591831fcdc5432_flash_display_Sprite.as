package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _02e5c105fe3ce8361c21dcd4677ffd0c75a3d0d07741aa0b4d591831fcdc5432_flash_display_Sprite extends Sprite
   {
       
      
      public function _02e5c105fe3ce8361c21dcd4677ffd0c75a3d0d07741aa0b4d591831fcdc5432_flash_display_Sprite()
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
