package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _105fe9d6707d158e9beadd438cd208e709658baed02045d7baf4ee907f71666a_flash_display_Sprite extends Sprite
   {
       
      
      public function _105fe9d6707d158e9beadd438cd208e709658baed02045d7baf4ee907f71666a_flash_display_Sprite()
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
