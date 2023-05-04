package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dde160edefaa919a1e286ee5e0dd6ec86126ec90864053b07b39c66163dbfe5f_flash_display_Sprite extends Sprite
   {
       
      
      public function _dde160edefaa919a1e286ee5e0dd6ec86126ec90864053b07b39c66163dbfe5f_flash_display_Sprite()
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
