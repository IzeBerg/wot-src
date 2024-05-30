package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0011d7017d0f49a2ac4cc5c6bef1098257ca114d6524142b4317ba309600b8d6_flash_display_Sprite extends Sprite
   {
       
      
      public function _0011d7017d0f49a2ac4cc5c6bef1098257ca114d6524142b4317ba309600b8d6_flash_display_Sprite()
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
