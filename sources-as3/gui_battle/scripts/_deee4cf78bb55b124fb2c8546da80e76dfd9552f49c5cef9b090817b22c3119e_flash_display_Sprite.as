package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _deee4cf78bb55b124fb2c8546da80e76dfd9552f49c5cef9b090817b22c3119e_flash_display_Sprite extends Sprite
   {
       
      
      public function _deee4cf78bb55b124fb2c8546da80e76dfd9552f49c5cef9b090817b22c3119e_flash_display_Sprite()
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
