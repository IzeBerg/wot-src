package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _eef9a4513c5cd380d59f396b439552460ea8b4139fc4f86b66937203bc3220a4_flash_display_Sprite extends Sprite
   {
       
      
      public function _eef9a4513c5cd380d59f396b439552460ea8b4139fc4f86b66937203bc3220a4_flash_display_Sprite()
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
