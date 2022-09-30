package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2917692c7c4291ef8346a5c90cb37b0ddc59c144febfa6e6d760a325e1c9f824_flash_display_Sprite extends Sprite
   {
       
      
      public function _2917692c7c4291ef8346a5c90cb37b0ddc59c144febfa6e6d760a325e1c9f824_flash_display_Sprite()
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
