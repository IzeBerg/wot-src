package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _522dd2c05fefd1f5fe834a0cde5cd1df1f9c889e6587fb114d44cb102c531228_flash_display_Sprite extends Sprite
   {
       
      
      public function _522dd2c05fefd1f5fe834a0cde5cd1df1f9c889e6587fb114d44cb102c531228_flash_display_Sprite()
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
