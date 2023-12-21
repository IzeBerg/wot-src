package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _278b300a92c425bb0ba7aad6cad60db491540b9f363759127fb8daac0b4d2beb_flash_display_Sprite extends Sprite
   {
       
      
      public function _278b300a92c425bb0ba7aad6cad60db491540b9f363759127fb8daac0b4d2beb_flash_display_Sprite()
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
