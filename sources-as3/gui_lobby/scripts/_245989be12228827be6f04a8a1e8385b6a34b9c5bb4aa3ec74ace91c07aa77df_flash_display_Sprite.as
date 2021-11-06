package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _245989be12228827be6f04a8a1e8385b6a34b9c5bb4aa3ec74ace91c07aa77df_flash_display_Sprite extends Sprite
   {
       
      
      public function _245989be12228827be6f04a8a1e8385b6a34b9c5bb4aa3ec74ace91c07aa77df_flash_display_Sprite()
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
