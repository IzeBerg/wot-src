package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1d0bf54d73e8f1a9f7cece9c0de00e6c79527c49426a4b6f07a9612303b71ce1_flash_display_Sprite extends Sprite
   {
       
      
      public function _1d0bf54d73e8f1a9f7cece9c0de00e6c79527c49426a4b6f07a9612303b71ce1_flash_display_Sprite()
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
