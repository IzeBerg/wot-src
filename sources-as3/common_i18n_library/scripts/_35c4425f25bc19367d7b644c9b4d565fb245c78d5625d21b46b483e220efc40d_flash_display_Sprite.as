package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _35c4425f25bc19367d7b644c9b4d565fb245c78d5625d21b46b483e220efc40d_flash_display_Sprite extends Sprite
   {
       
      
      public function _35c4425f25bc19367d7b644c9b4d565fb245c78d5625d21b46b483e220efc40d_flash_display_Sprite()
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
