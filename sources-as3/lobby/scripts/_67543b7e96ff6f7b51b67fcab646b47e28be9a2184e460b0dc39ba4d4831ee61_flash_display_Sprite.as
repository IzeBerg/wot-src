package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _67543b7e96ff6f7b51b67fcab646b47e28be9a2184e460b0dc39ba4d4831ee61_flash_display_Sprite extends Sprite
   {
       
      
      public function _67543b7e96ff6f7b51b67fcab646b47e28be9a2184e460b0dc39ba4d4831ee61_flash_display_Sprite()
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
