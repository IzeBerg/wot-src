package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _88998785a15459ec3e603d08f10d13053dbb55893ee151e44b0b91ff0095113b_flash_display_Sprite extends Sprite
   {
       
      
      public function _88998785a15459ec3e603d08f10d13053dbb55893ee151e44b0b91ff0095113b_flash_display_Sprite()
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
