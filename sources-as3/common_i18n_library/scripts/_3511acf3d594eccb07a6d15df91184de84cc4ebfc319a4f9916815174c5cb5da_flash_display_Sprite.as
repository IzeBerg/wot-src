package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3511acf3d594eccb07a6d15df91184de84cc4ebfc319a4f9916815174c5cb5da_flash_display_Sprite extends Sprite
   {
       
      
      public function _3511acf3d594eccb07a6d15df91184de84cc4ebfc319a4f9916815174c5cb5da_flash_display_Sprite()
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
