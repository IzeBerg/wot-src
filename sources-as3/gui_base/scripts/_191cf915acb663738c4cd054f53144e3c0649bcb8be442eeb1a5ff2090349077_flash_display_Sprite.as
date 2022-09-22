package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _191cf915acb663738c4cd054f53144e3c0649bcb8be442eeb1a5ff2090349077_flash_display_Sprite extends Sprite
   {
       
      
      public function _191cf915acb663738c4cd054f53144e3c0649bcb8be442eeb1a5ff2090349077_flash_display_Sprite()
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
