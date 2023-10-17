package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7ffb23feba93b32ac642ffa3c3f238aca1bc65eec32d6895b094fdcb4c5fc910_flash_display_Sprite extends Sprite
   {
       
      
      public function _7ffb23feba93b32ac642ffa3c3f238aca1bc65eec32d6895b094fdcb4c5fc910_flash_display_Sprite()
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
