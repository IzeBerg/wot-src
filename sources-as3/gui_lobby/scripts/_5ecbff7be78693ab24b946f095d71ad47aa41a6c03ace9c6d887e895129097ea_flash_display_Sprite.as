package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5ecbff7be78693ab24b946f095d71ad47aa41a6c03ace9c6d887e895129097ea_flash_display_Sprite extends Sprite
   {
       
      
      public function _5ecbff7be78693ab24b946f095d71ad47aa41a6c03ace9c6d887e895129097ea_flash_display_Sprite()
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
