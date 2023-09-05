package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ed88e5a230065069b90b8347e76e283becddeba7dfe77686a038303bf20e3186_flash_display_Sprite extends Sprite
   {
       
      
      public function _ed88e5a230065069b90b8347e76e283becddeba7dfe77686a038303bf20e3186_flash_display_Sprite()
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
