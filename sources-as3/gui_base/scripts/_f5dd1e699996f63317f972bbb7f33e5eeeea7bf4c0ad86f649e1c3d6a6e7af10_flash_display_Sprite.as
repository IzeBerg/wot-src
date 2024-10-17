package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f5dd1e699996f63317f972bbb7f33e5eeeea7bf4c0ad86f649e1c3d6a6e7af10_flash_display_Sprite extends Sprite
   {
       
      
      public function _f5dd1e699996f63317f972bbb7f33e5eeeea7bf4c0ad86f649e1c3d6a6e7af10_flash_display_Sprite()
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
