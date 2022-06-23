package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c663fa789a21ae89eae6ccb92a00258b0963b8c87b30e9242eabda9d842160b4_flash_display_Sprite extends Sprite
   {
       
      
      public function _c663fa789a21ae89eae6ccb92a00258b0963b8c87b30e9242eabda9d842160b4_flash_display_Sprite()
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
