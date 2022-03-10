package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _052d982da2a05dd360c1ecc2b66ed7223e7f47dc94ce1bee4ba77d7dc62ed92c_flash_display_Sprite extends Sprite
   {
       
      
      public function _052d982da2a05dd360c1ecc2b66ed7223e7f47dc94ce1bee4ba77d7dc62ed92c_flash_display_Sprite()
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
