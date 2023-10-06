package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fb94a9b8bdaaccae465e5b62b28c3df2656b61f642749a7fb36d773cb63a03ff_flash_display_Sprite extends Sprite
   {
       
      
      public function _fb94a9b8bdaaccae465e5b62b28c3df2656b61f642749a7fb36d773cb63a03ff_flash_display_Sprite()
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
