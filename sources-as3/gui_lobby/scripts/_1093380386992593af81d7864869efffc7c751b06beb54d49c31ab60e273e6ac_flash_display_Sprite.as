package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1093380386992593af81d7864869efffc7c751b06beb54d49c31ab60e273e6ac_flash_display_Sprite extends Sprite
   {
       
      
      public function _1093380386992593af81d7864869efffc7c751b06beb54d49c31ab60e273e6ac_flash_display_Sprite()
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
