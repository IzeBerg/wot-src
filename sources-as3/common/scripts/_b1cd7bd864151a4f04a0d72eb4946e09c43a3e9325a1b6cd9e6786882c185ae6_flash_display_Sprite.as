package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b1cd7bd864151a4f04a0d72eb4946e09c43a3e9325a1b6cd9e6786882c185ae6_flash_display_Sprite extends Sprite
   {
       
      
      public function _b1cd7bd864151a4f04a0d72eb4946e09c43a3e9325a1b6cd9e6786882c185ae6_flash_display_Sprite()
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
