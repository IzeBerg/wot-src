package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4eb4c64e73dc3e177116c24414dba05b65fea12abf3c1e2a938113b6e714ce5d_flash_display_Sprite extends Sprite
   {
       
      
      public function _4eb4c64e73dc3e177116c24414dba05b65fea12abf3c1e2a938113b6e714ce5d_flash_display_Sprite()
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
