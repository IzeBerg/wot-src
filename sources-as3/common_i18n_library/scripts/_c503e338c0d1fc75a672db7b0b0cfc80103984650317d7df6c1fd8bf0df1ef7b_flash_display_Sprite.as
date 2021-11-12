package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c503e338c0d1fc75a672db7b0b0cfc80103984650317d7df6c1fd8bf0df1ef7b_flash_display_Sprite extends Sprite
   {
       
      
      public function _c503e338c0d1fc75a672db7b0b0cfc80103984650317d7df6c1fd8bf0df1ef7b_flash_display_Sprite()
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
