package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _17a250970a7304351d29b52e5742a905be1be624ab893ed7f8d5bc6b95e90bd4_flash_display_Sprite extends Sprite
   {
       
      
      public function _17a250970a7304351d29b52e5742a905be1be624ab893ed7f8d5bc6b95e90bd4_flash_display_Sprite()
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
