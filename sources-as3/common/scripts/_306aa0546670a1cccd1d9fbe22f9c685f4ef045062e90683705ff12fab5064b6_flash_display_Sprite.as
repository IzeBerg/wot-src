package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _306aa0546670a1cccd1d9fbe22f9c685f4ef045062e90683705ff12fab5064b6_flash_display_Sprite extends Sprite
   {
       
      
      public function _306aa0546670a1cccd1d9fbe22f9c685f4ef045062e90683705ff12fab5064b6_flash_display_Sprite()
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
