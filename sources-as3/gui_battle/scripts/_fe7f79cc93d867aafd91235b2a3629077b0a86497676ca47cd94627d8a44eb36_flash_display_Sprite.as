package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fe7f79cc93d867aafd91235b2a3629077b0a86497676ca47cd94627d8a44eb36_flash_display_Sprite extends Sprite
   {
       
      
      public function _fe7f79cc93d867aafd91235b2a3629077b0a86497676ca47cd94627d8a44eb36_flash_display_Sprite()
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
