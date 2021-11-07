package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _148c9047a38d09ac57e6d5b2ffb838761f43ce6feacae3a825ad71cfff1815e1_flash_display_Sprite extends Sprite
   {
       
      
      public function _148c9047a38d09ac57e6d5b2ffb838761f43ce6feacae3a825ad71cfff1815e1_flash_display_Sprite()
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
