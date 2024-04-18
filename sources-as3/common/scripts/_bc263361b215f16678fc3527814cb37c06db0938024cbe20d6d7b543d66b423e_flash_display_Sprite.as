package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bc263361b215f16678fc3527814cb37c06db0938024cbe20d6d7b543d66b423e_flash_display_Sprite extends Sprite
   {
       
      
      public function _bc263361b215f16678fc3527814cb37c06db0938024cbe20d6d7b543d66b423e_flash_display_Sprite()
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
