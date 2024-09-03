package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _616b05eb74b1293b9b30d48ba9891d6abfb34223d9339d5bc1a10fd96a3fef0e_flash_display_Sprite extends Sprite
   {
       
      
      public function _616b05eb74b1293b9b30d48ba9891d6abfb34223d9339d5bc1a10fd96a3fef0e_flash_display_Sprite()
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
