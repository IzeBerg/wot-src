package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _21cd7520306f0e0088321feba0b88e08adfdf53da14d61d3fde542630eed3ba3_flash_display_Sprite extends Sprite
   {
       
      
      public function _21cd7520306f0e0088321feba0b88e08adfdf53da14d61d3fde542630eed3ba3_flash_display_Sprite()
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
