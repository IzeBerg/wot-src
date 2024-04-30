package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _707e7cd6de258343d27d42b0925ebbeaa1f852b15b8c3fa4a066fd94341cf05c_flash_display_Sprite extends Sprite
   {
       
      
      public function _707e7cd6de258343d27d42b0925ebbeaa1f852b15b8c3fa4a066fd94341cf05c_flash_display_Sprite()
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
