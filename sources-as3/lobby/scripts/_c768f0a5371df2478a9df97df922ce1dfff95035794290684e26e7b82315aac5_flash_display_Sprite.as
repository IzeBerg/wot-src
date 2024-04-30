package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c768f0a5371df2478a9df97df922ce1dfff95035794290684e26e7b82315aac5_flash_display_Sprite extends Sprite
   {
       
      
      public function _c768f0a5371df2478a9df97df922ce1dfff95035794290684e26e7b82315aac5_flash_display_Sprite()
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
