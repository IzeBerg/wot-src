package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1757199c09be29ff68bb6a5839064b8f464b0054b247b5e4e2b18411aae2b1ff_flash_display_Sprite extends Sprite
   {
       
      
      public function _1757199c09be29ff68bb6a5839064b8f464b0054b247b5e4e2b18411aae2b1ff_flash_display_Sprite()
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
