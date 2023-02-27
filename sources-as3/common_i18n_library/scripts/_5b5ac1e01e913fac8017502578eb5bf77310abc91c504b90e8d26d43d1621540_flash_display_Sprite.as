package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5b5ac1e01e913fac8017502578eb5bf77310abc91c504b90e8d26d43d1621540_flash_display_Sprite extends Sprite
   {
       
      
      public function _5b5ac1e01e913fac8017502578eb5bf77310abc91c504b90e8d26d43d1621540_flash_display_Sprite()
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
