package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8ddbf0dcbda900839780fedb9c5bf65e1e0245429c67beba836d1de1f303f61f_flash_display_Sprite extends Sprite
   {
       
      
      public function _8ddbf0dcbda900839780fedb9c5bf65e1e0245429c67beba836d1de1f303f61f_flash_display_Sprite()
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
