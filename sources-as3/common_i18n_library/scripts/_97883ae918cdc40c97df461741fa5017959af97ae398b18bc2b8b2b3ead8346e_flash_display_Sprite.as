package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _97883ae918cdc40c97df461741fa5017959af97ae398b18bc2b8b2b3ead8346e_flash_display_Sprite extends Sprite
   {
       
      
      public function _97883ae918cdc40c97df461741fa5017959af97ae398b18bc2b8b2b3ead8346e_flash_display_Sprite()
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
