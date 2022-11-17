package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d755174427aa12ec6267f50dc356831031e79fb2776f791b1abaf65804650e89_flash_display_Sprite extends Sprite
   {
       
      
      public function _d755174427aa12ec6267f50dc356831031e79fb2776f791b1abaf65804650e89_flash_display_Sprite()
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
