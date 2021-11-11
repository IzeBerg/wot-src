package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9a407473d6f80c53edd60e811688e2c67f054967a016af7c120797065985414b_flash_display_Sprite extends Sprite
   {
       
      
      public function _9a407473d6f80c53edd60e811688e2c67f054967a016af7c120797065985414b_flash_display_Sprite()
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
