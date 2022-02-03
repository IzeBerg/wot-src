package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5b75e636b3f000196056262a96f7e963a897b6c4e5c6e20ec27e42ab34a9ab7b_flash_display_Sprite extends Sprite
   {
       
      
      public function _5b75e636b3f000196056262a96f7e963a897b6c4e5c6e20ec27e42ab34a9ab7b_flash_display_Sprite()
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
