package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _87a76a8bd0898be5423aea4711ee5220d3ba7a6065e71560c868abe9a11e53e3_flash_display_Sprite extends Sprite
   {
       
      
      public function _87a76a8bd0898be5423aea4711ee5220d3ba7a6065e71560c868abe9a11e53e3_flash_display_Sprite()
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
