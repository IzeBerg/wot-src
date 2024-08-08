package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _249c8365cf3aeebd77d6fb88347d76284165d21d4c385f8bc8df5a9741d0cb94_flash_display_Sprite extends Sprite
   {
       
      
      public function _249c8365cf3aeebd77d6fb88347d76284165d21d4c385f8bc8df5a9741d0cb94_flash_display_Sprite()
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
