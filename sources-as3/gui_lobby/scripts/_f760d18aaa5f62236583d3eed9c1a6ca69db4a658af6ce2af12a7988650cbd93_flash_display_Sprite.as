package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f760d18aaa5f62236583d3eed9c1a6ca69db4a658af6ce2af12a7988650cbd93_flash_display_Sprite extends Sprite
   {
       
      
      public function _f760d18aaa5f62236583d3eed9c1a6ca69db4a658af6ce2af12a7988650cbd93_flash_display_Sprite()
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
