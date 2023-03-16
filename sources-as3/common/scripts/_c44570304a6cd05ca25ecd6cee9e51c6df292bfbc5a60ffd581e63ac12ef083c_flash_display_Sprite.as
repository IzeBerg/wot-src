package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c44570304a6cd05ca25ecd6cee9e51c6df292bfbc5a60ffd581e63ac12ef083c_flash_display_Sprite extends Sprite
   {
       
      
      public function _c44570304a6cd05ca25ecd6cee9e51c6df292bfbc5a60ffd581e63ac12ef083c_flash_display_Sprite()
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
