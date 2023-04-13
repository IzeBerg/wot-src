package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1023301167e42b683627bac0de621dc846ed44285e57c7cdeb9cfbd0838658ca_flash_display_Sprite extends Sprite
   {
       
      
      public function _1023301167e42b683627bac0de621dc846ed44285e57c7cdeb9cfbd0838658ca_flash_display_Sprite()
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
