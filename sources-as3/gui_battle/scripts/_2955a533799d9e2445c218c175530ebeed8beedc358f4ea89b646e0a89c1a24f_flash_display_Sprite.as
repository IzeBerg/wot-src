package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2955a533799d9e2445c218c175530ebeed8beedc358f4ea89b646e0a89c1a24f_flash_display_Sprite extends Sprite
   {
       
      
      public function _2955a533799d9e2445c218c175530ebeed8beedc358f4ea89b646e0a89c1a24f_flash_display_Sprite()
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
