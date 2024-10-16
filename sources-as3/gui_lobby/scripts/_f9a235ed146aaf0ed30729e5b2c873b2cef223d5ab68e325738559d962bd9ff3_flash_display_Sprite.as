package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f9a235ed146aaf0ed30729e5b2c873b2cef223d5ab68e325738559d962bd9ff3_flash_display_Sprite extends Sprite
   {
       
      
      public function _f9a235ed146aaf0ed30729e5b2c873b2cef223d5ab68e325738559d962bd9ff3_flash_display_Sprite()
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
