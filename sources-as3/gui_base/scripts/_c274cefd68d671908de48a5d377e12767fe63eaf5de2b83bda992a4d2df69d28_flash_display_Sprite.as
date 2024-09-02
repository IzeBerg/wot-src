package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c274cefd68d671908de48a5d377e12767fe63eaf5de2b83bda992a4d2df69d28_flash_display_Sprite extends Sprite
   {
       
      
      public function _c274cefd68d671908de48a5d377e12767fe63eaf5de2b83bda992a4d2df69d28_flash_display_Sprite()
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
