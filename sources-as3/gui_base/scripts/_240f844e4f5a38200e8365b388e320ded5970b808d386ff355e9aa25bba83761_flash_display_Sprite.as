package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _240f844e4f5a38200e8365b388e320ded5970b808d386ff355e9aa25bba83761_flash_display_Sprite extends Sprite
   {
       
      
      public function _240f844e4f5a38200e8365b388e320ded5970b808d386ff355e9aa25bba83761_flash_display_Sprite()
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
