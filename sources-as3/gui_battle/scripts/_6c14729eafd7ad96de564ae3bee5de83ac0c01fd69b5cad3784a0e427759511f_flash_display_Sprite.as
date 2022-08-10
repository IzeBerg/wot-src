package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6c14729eafd7ad96de564ae3bee5de83ac0c01fd69b5cad3784a0e427759511f_flash_display_Sprite extends Sprite
   {
       
      
      public function _6c14729eafd7ad96de564ae3bee5de83ac0c01fd69b5cad3784a0e427759511f_flash_display_Sprite()
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
