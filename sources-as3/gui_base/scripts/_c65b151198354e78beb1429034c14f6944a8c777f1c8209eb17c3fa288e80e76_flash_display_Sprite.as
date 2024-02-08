package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c65b151198354e78beb1429034c14f6944a8c777f1c8209eb17c3fa288e80e76_flash_display_Sprite extends Sprite
   {
       
      
      public function _c65b151198354e78beb1429034c14f6944a8c777f1c8209eb17c3fa288e80e76_flash_display_Sprite()
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
