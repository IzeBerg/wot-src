package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fab290ef5d24c67e671e3fe92be7735f1af6c2eec9a2a79a55928d20aa43635a_flash_display_Sprite extends Sprite
   {
       
      
      public function _fab290ef5d24c67e671e3fe92be7735f1af6c2eec9a2a79a55928d20aa43635a_flash_display_Sprite()
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
