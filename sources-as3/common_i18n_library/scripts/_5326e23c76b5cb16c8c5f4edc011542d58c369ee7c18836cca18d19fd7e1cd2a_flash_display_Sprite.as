package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5326e23c76b5cb16c8c5f4edc011542d58c369ee7c18836cca18d19fd7e1cd2a_flash_display_Sprite extends Sprite
   {
       
      
      public function _5326e23c76b5cb16c8c5f4edc011542d58c369ee7c18836cca18d19fd7e1cd2a_flash_display_Sprite()
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
