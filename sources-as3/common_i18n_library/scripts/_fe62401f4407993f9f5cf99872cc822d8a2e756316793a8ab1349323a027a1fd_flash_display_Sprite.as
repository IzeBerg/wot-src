package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fe62401f4407993f9f5cf99872cc822d8a2e756316793a8ab1349323a027a1fd_flash_display_Sprite extends Sprite
   {
       
      
      public function _fe62401f4407993f9f5cf99872cc822d8a2e756316793a8ab1349323a027a1fd_flash_display_Sprite()
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
