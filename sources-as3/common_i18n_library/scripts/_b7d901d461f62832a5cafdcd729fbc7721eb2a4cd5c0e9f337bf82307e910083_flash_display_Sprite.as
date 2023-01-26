package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b7d901d461f62832a5cafdcd729fbc7721eb2a4cd5c0e9f337bf82307e910083_flash_display_Sprite extends Sprite
   {
       
      
      public function _b7d901d461f62832a5cafdcd729fbc7721eb2a4cd5c0e9f337bf82307e910083_flash_display_Sprite()
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
