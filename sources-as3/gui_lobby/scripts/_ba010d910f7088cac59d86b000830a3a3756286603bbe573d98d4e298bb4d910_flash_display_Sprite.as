package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ba010d910f7088cac59d86b000830a3a3756286603bbe573d98d4e298bb4d910_flash_display_Sprite extends Sprite
   {
       
      
      public function _ba010d910f7088cac59d86b000830a3a3756286603bbe573d98d4e298bb4d910_flash_display_Sprite()
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
