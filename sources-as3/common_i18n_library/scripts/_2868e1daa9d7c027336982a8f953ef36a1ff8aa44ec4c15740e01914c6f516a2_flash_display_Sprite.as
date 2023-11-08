package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2868e1daa9d7c027336982a8f953ef36a1ff8aa44ec4c15740e01914c6f516a2_flash_display_Sprite extends Sprite
   {
       
      
      public function _2868e1daa9d7c027336982a8f953ef36a1ff8aa44ec4c15740e01914c6f516a2_flash_display_Sprite()
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
