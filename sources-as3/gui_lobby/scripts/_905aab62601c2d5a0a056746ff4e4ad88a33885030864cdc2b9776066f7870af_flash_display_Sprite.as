package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _905aab62601c2d5a0a056746ff4e4ad88a33885030864cdc2b9776066f7870af_flash_display_Sprite extends Sprite
   {
       
      
      public function _905aab62601c2d5a0a056746ff4e4ad88a33885030864cdc2b9776066f7870af_flash_display_Sprite()
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
