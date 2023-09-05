package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _537fd3f19415cd5c1d8b91a13426f9e438bf0801c8f16741664bf4f359fc9652_flash_display_Sprite extends Sprite
   {
       
      
      public function _537fd3f19415cd5c1d8b91a13426f9e438bf0801c8f16741664bf4f359fc9652_flash_display_Sprite()
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
