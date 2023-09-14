package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f1b91a9a49daa5ca2dddd2d81fd56c679d47a0076e5398a583e9433cc7156d95_flash_display_Sprite extends Sprite
   {
       
      
      public function _f1b91a9a49daa5ca2dddd2d81fd56c679d47a0076e5398a583e9433cc7156d95_flash_display_Sprite()
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
