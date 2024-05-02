package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _caac26befbc43e17c24d928dcbdfeaa72698721948de46555cbf1c04c7b7835c_flash_display_Sprite extends Sprite
   {
       
      
      public function _caac26befbc43e17c24d928dcbdfeaa72698721948de46555cbf1c04c7b7835c_flash_display_Sprite()
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
