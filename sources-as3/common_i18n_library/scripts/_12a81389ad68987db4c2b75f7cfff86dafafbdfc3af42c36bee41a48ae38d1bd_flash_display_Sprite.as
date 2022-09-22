package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _12a81389ad68987db4c2b75f7cfff86dafafbdfc3af42c36bee41a48ae38d1bd_flash_display_Sprite extends Sprite
   {
       
      
      public function _12a81389ad68987db4c2b75f7cfff86dafafbdfc3af42c36bee41a48ae38d1bd_flash_display_Sprite()
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
