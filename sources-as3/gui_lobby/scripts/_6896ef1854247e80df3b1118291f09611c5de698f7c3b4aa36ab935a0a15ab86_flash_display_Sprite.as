package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6896ef1854247e80df3b1118291f09611c5de698f7c3b4aa36ab935a0a15ab86_flash_display_Sprite extends Sprite
   {
       
      
      public function _6896ef1854247e80df3b1118291f09611c5de698f7c3b4aa36ab935a0a15ab86_flash_display_Sprite()
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
