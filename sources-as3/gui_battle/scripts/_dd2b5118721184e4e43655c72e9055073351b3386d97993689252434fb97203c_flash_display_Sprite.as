package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dd2b5118721184e4e43655c72e9055073351b3386d97993689252434fb97203c_flash_display_Sprite extends Sprite
   {
       
      
      public function _dd2b5118721184e4e43655c72e9055073351b3386d97993689252434fb97203c_flash_display_Sprite()
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
