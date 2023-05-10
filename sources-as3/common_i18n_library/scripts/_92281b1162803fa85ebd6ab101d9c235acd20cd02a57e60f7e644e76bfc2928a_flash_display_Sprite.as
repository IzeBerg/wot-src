package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _92281b1162803fa85ebd6ab101d9c235acd20cd02a57e60f7e644e76bfc2928a_flash_display_Sprite extends Sprite
   {
       
      
      public function _92281b1162803fa85ebd6ab101d9c235acd20cd02a57e60f7e644e76bfc2928a_flash_display_Sprite()
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
