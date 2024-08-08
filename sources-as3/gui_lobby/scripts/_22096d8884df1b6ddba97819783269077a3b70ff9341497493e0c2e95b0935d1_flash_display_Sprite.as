package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _22096d8884df1b6ddba97819783269077a3b70ff9341497493e0c2e95b0935d1_flash_display_Sprite extends Sprite
   {
       
      
      public function _22096d8884df1b6ddba97819783269077a3b70ff9341497493e0c2e95b0935d1_flash_display_Sprite()
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
