package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1d357ccf5059456a0ae66d8d76c1727249e7fe26da89920c4ab139fea0089f09_flash_display_Sprite extends Sprite
   {
       
      
      public function _1d357ccf5059456a0ae66d8d76c1727249e7fe26da89920c4ab139fea0089f09_flash_display_Sprite()
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
