package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2a73cf17b11e59c3abaf910ada99367ac43456212929cbc0239a8c16888280fe_flash_display_Sprite extends Sprite
   {
       
      
      public function _2a73cf17b11e59c3abaf910ada99367ac43456212929cbc0239a8c16888280fe_flash_display_Sprite()
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
