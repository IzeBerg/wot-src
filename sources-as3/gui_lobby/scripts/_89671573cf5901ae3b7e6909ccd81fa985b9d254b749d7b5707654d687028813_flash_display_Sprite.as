package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _89671573cf5901ae3b7e6909ccd81fa985b9d254b749d7b5707654d687028813_flash_display_Sprite extends Sprite
   {
       
      
      public function _89671573cf5901ae3b7e6909ccd81fa985b9d254b749d7b5707654d687028813_flash_display_Sprite()
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
