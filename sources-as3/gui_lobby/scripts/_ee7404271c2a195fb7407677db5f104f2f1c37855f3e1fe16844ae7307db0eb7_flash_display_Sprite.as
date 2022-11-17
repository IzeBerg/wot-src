package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ee7404271c2a195fb7407677db5f104f2f1c37855f3e1fe16844ae7307db0eb7_flash_display_Sprite extends Sprite
   {
       
      
      public function _ee7404271c2a195fb7407677db5f104f2f1c37855f3e1fe16844ae7307db0eb7_flash_display_Sprite()
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
