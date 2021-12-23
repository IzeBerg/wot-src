package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dad5bfd3a48b7847075e2bf7a65606e14591f1c893550d3b90d019389e54af62_flash_display_Sprite extends Sprite
   {
       
      
      public function _dad5bfd3a48b7847075e2bf7a65606e14591f1c893550d3b90d019389e54af62_flash_display_Sprite()
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
