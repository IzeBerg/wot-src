package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _461cde72cc20d9d2071f031d5380f526a20daf78d84d6defd6b1b3e5ac8c7c09_flash_display_Sprite extends Sprite
   {
       
      
      public function _461cde72cc20d9d2071f031d5380f526a20daf78d84d6defd6b1b3e5ac8c7c09_flash_display_Sprite()
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
