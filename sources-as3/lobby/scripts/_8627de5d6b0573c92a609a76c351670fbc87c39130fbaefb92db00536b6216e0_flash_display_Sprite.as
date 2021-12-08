package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8627de5d6b0573c92a609a76c351670fbc87c39130fbaefb92db00536b6216e0_flash_display_Sprite extends Sprite
   {
       
      
      public function _8627de5d6b0573c92a609a76c351670fbc87c39130fbaefb92db00536b6216e0_flash_display_Sprite()
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
