package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _534ed70fa9c6fc0b6c2252822d250556e4acf24f9afc70374a9c8aa9731a9e62_flash_display_Sprite extends Sprite
   {
       
      
      public function _534ed70fa9c6fc0b6c2252822d250556e4acf24f9afc70374a9c8aa9731a9e62_flash_display_Sprite()
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
