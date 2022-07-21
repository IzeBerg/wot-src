package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e66dba7ff977e092495d936177d5cb977784d6c6f0c9430ff52c066872fe66de_flash_display_Sprite extends Sprite
   {
       
      
      public function _e66dba7ff977e092495d936177d5cb977784d6c6f0c9430ff52c066872fe66de_flash_display_Sprite()
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
