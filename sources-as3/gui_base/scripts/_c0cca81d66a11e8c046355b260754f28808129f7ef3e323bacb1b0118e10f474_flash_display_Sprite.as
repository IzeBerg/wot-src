package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c0cca81d66a11e8c046355b260754f28808129f7ef3e323bacb1b0118e10f474_flash_display_Sprite extends Sprite
   {
       
      
      public function _c0cca81d66a11e8c046355b260754f28808129f7ef3e323bacb1b0118e10f474_flash_display_Sprite()
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
